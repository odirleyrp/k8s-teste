variable "AWS_REGION" {
  default = "us-west-2"
}

variable "vpc_id" {
  default = "vpc-035385354b7c905df"
}

variable "requerente" {
  default = "DANIELA FALOPPA"

}

variable "map_public_true" {
  default = "true"
}

variable "ENV" {
  default = "hml"

}

#######################SQS#########################

variable "SQS_NAME" {
  default = "CBIO_"

}
variable "NOVA_ORDEM_CBIO_SQS" {
  default = "_nova_ordem_cbio_"
}


variable "CANCELA_COMPRA_CBIO_SQS" {
  default = "_cancela_compra_cbio_"
}


variable "CANCELA_VENDA_CBIO_SQS" {
  default = "_cancela_venda_cbio_"
}


variable "MATCH_CBIO_SQS" {
  default = "_match_cbio_"
}

variable "FINALIZA_VARREDURA_CBIO_SQS" {
  default = "_finaliza_varredura_cbio_"
}

#####################################EKS############################
variable "RANGE_SG_IPS" {
  default = ["12.67.0.0/16", "10.7.60.0/24", "10.7.90.0/24", "10.7.30.0/24"]
}
variable "name_prefix" {
  default = "ehub-eks-"
}

variable "cluster-name" {
  default = "ehub-eks"
}

variable subnets_ids {
  default = ["subnet-08ef4b6396fd84e3b", "subnet-0545e8cda321fbfd7", "subnet-0d6f649ee7474a07b", "subnet-0d864723760baeb09"]
}

variable "keyName" {
  default     = "us-west-2_bbce_dev"
  description = "Nome da chave de conta"
}

variable "versionCluster" {
  default = "1.19"
}

variable services_ports {
  default = [
    "22"
  ]
  description = "lista de portas "
}


variable "map_roles" {
  description = "AdditionalIAMrolestoaddtotheaws-authconfigmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::993324252386:role/EKS_AssumeRole"
      username = "EKS_AssumeRole"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::993324252386:role/Admin_AssumeRole"
      username = "Admin_AssumeRole"
      groups   = ["system:masters"]
    },
  ]
}



variable "AWS_TYPE_INSTANCE" {
  default     = "t2.large"
  description = "tipo da instancia"
}

variable "DEKS" {
  default = "4"

}

variable "DMAXEKS" {
  default = "8"

}

variable "DMIN" {
  default = "4"
}
###############################ALB###################


variable "ALB_NAME" {
  default = "ehub_nodes_"
}

variable "INTERNAL_ALB" {
  default = true
}

variable "IDLE_TIMEOUT" {
  default = "60"
}

variable "TYPEALB" {
  default = "application"
}

variable "PRIORITY" {
  default = "100"
}

variable "ALB_PATH" {
  default = "/static/*"
}

variable "TARGET_GROUP_NAME" {
  default = "ehub-k8s"
}

variable "TARGET_GROUP_STICKY" {
  default = true
}

variable "TARGET_GROUP_PATH" {
  default = "/"
}

variable "ENV-ALB" {
  default = "ehub-bbce"
}

variable "ENVIO" {
  default = "homologa"

}


###################APIGTW##############

variable "name-api-gtw" {
  default = "api-gtw-vpc-link"
}

variable "env-name-api-gtw" {
  default = "homologa"

}


######################schedule################

variable "scheduled_action_name_start" {
  default = "start"

}

variable "scheduled_action_name_stop" {
  default = "stop"

}

variable recurrence_start {
  default     = "0 09 * * MON-FRI"
  description = "Hora para ligar maquinas"
}

variable recurrence_stop {
  default     = "30 23 * * MON-FRI"
  description = "Hora para deligar maquinas"
}


###############DOCUMENTDB##########################
variable name_document_db {
  default     = "ehub-eks-homog"
  description = "description"
}

variable master_username {
  default     = "ehub-eks"
  description = "USER DB"
}
variable master_password {
  default     = "QkJjZWhvbW9tb2xvZ0EhRE9jdW1lbnREQgo="
  description = "PASS"
}
variable availability_zones {
  default     = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  description = "lista de azs"
}


variable backup_retention_period_db {
  default     = "2"
  description = "numero de vezes a rodar o backup"
}


variable skip_final_snapshot {
  default     = "true"
  description = "pular o snapshot ao prover recurso"
}
variable preferred_backup_window {
  default     = "07:00-09:00"
  description = "Hora que será iniciado o backup"
}

variable port_db {
  default     = "32232"
  description = "Porta para acesso ao banco"
}

################CLUSTER RDS###################

variable cluster_identifier {
  default     = "ehub_cluster_"
  description = "Nome do cluster"
}


variable master_username_cluster {
  default     = "ehubcluster"
  description = "usuário master do cluster"
}

variable master_password_cluster {
  default     = "IURPY3VtZW50REIK"
  description = "password master do cluster"
}

variable backup_retention_period_cluster {
  default     = "3"
  description = "Numero de quantidades de retenção de backup"
}

variable preferred_backup_window_cluster {
  default     = "07:00-09:00"
  description = "Janela para início do backup"
}

variable NAME_CLUSTER_RDS {
  default     = "ehubcluster"
  description = "Nome de exemplo do cluster"
}

variable AWS_INSTANCE_CLASS_RDS {
  default     = "db.t3.2xlarge"
  description = "Tipo de Instancia RDS"
}

variable COUNT {
  default     = "3"
  description = "número de instancias"
}

variable PORT_CLUSTER {
  default     = "3306"
  description = "description"
}

variable "RANGE_IPS_SR" {
  default = ["12.67.0.0/16", "10.87.0.0/16", "10.7.60.0/24", "10.7.90.0/24", "10.7.30.0/24"]

}