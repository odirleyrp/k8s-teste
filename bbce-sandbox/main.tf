locals {
  cluster_name = "ehub-qa" 
  common_tags  = {
    ambiente                 = "qa"
    app                      = "ehub"
    modalidade               = "sustentacao"
    requerente               = "Orly"
    terraform                = true
  }
}

data aws_vpc vpc {
  filter {
    name = "tag:Name"
    values = ["vpc-ehub"]
  }
}

data aws_subnet_ids private {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Type = "private"
  }
}

module eks {
  source                          = "./aws-eks"
  cluster_name                    = local.cluster_name
  cluster_version                 = "1.20"
  cluster_enabled_log_types       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_log_retention_in_days   = 1827
  key_name                        = var.key_name
  
  vpc_id                          = data.aws_vpc.vpc.id
  subnets                         = data.aws_subnet_ids.private.ids
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  worker_groups = [
    {
      name                        = "worker-group-ndf-api"
      instance_type               = "t3a.small"
      key_name                    = var.key_name
      kubelet_extra_args          = "--node-labels=ndf=microservices"
      asg_desired_capacity        = 2
    }
  ]

  map_roles                       = var.map_roles
  tags                            = merge(local.common_tags)
}

data aws_eks_cluster cluster {
  name = module.eks.cluster_id
}

data aws_eks_cluster_auth cluster {
  name = module.eks.cluster_id
}

provider kubernetes {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

