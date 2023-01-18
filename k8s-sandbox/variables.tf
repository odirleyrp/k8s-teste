variable "map_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::822956234201:role/EKS_AssumeRole"
      username = "EKS_AssumeRole"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::822956234201:role/Admin_AssumeRole"
      username = "Admin_AssumeRole"
      groups   = ["system:masters"]
    },
  ]
}

variable "key_name" {}