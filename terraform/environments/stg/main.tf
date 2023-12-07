# common local variables
locals {
  region     = "us-west-2"
  account_id = "123456789012"
  env        = "stg"
}

# terraform configuration with s3 backend
terraform {
  backend "s3" {
    bucket = "elnaterator-terraform-state-bucket"
    key    = "terraform-aws-glue-example-app-stg.tfstate"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# provider configuration
provider "aws" {
  region              = local.region
  allowed_account_ids = [local.account_id]
}
