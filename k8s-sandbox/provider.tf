terraform {
    required_version = ">=0.12.31"
    required_providers {
      aws = ">=3.54.0"
      local = ">=2.1.0"
    }
}

provider "aws" {
  region = "us-west-2"
}