data aws_vpc vpc {
  filter {
    name = "tag:Name"
    values = ["EHUB"]
  }
}

data aws_subnet_ids private {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Type = "app"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

module "SG" {
  source = "git::git@ssh.dev.azure.com:v3/bbce0256/Infra%20as%20Code%20-%20BBCE/security-group"
  name = "sg_ehub_eks_hml"
  vpc_id = data.aws_vpc.vpc.id
  sg_ingress = {
    "22" = ["10.87.0.0/16", "10.57.0.0/16", "12.47.0.0/16"]
  }
  tags = {
    Name                                                   = "${var.cluster-name}-${var.ENV}"
    Terraform                                              = true
    APP                                                    = "EHUB"
    Projeto                                                = "EHUB"
    Requerente                                             = "${var.requerente}"
    Ambiente                                               = "${var.ENV}"
  }
}

module "eks" {
  source                               = "git::git@ssh.dev.azure.com:v3/bbce0256/Infra%20as%20Code%20-%20BBCE/ehub-eks-sg-schedule"
  cluster_name                         = "${var.cluster-name}-${var.ENV}"
  subnets                              = data.aws_subnet_ids.private.ids
  vpc_id                               = data.aws_vpc.vpc.id
  map_roles                            = "${var.map_roles}"
  worker_additional_security_group_ids = ["${module.SG.id}"]
  manage_aws_auth                      = true
  cluster_enabled_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_in_days        = 180
  key_name                             = "${var.keyName}"
  cluster_version                      = "${var.versionCluster}"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = false
  worker_groups = [
    {
      name                          = "workgroup-ehub-eks-hml"
      instance_type                 = "t3a.large"
      asg_max_size                  = 5
      asg_desired_capacity          = 5
      kubelet_extra_args            = "--node-labels=ehub=microservices"
    },
    {
      name                          = "workgroup-ehub-eks-legado-hml"
      instance_type                 = "t3a.large"
      asg_max_size                  = 1
      asg_desired_capacity          = 1
      kubelet_extra_args            = "--node-labels=ndf=microservices"
    },
    {
      name                          = "workgroup-ehub-eks-hmlops-hml"
      instance_type                 = "t3a.large"
      asg_max_size                  = 1
      asg_desired_capacity          = 1
      kubelet_extra_args            = "--node-labels=group=devops"
    }
  ]
  tags = {
    Name                                                   = "${var.cluster-name}-${var.ENV}"
    Terraform                                              = true
    APP                                                    = "EHUB"
    Projeto                                                = "EHUB"
    Requerente                                             = "${var.requerente}"
    Ambiente                                               = "${var.ENV}"
    "kubernetes.io/cluster/${var.cluster-name}-${var.ENV}" = "shared"

  }
}

module "SCHEDULE" {
  source                      = "git::git@ssh.dev.azure.com:v3/bbce0256/Infra%20as%20Code%20-%20BBCE/schedule-eks"
  min_size_start              = 1
  max_size_start              = 5
  desired_capacity_start      = 5
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[0]
}

module "SCHEDULE-1" {
  source                      = "git::git@ssh.dev.azure.com:v3/bbce0256/Infra%20as%20Code%20-%20BBCE/schedule-eks"
  min_size_start              = 1
  max_size_start              = 1
  desired_capacity_start      = 1
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[1]
}

module "SCHEDULE-2" {
  source                      = "git::git@ssh.dev.azure.com:v3/bbce0256/Infra%20as%20Code%20-%20BBCE/schedule-eks"
  min_size_start              = 1
  max_size_start              = 1
  desired_capacity_start      = 1
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[2]
}