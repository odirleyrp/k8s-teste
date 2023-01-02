terraform {
  backend "s3" {
    bucket  = "iac-terraform-qa"
    encrypt = true
    key     = "balcao/my-cluster-terraform.tfstate"
    region  = "us-west-2"
  }
}