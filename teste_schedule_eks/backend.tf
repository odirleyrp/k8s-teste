terraform {
  backend "s3" {
    bucket  = "iac-be-shared-terraform/"
    encrypt = true
    key     = "bbce-homologa/ehub-eks-hml"
    region  = "us-west-2"
  }
}