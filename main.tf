terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

    backend "s3" {}
}

provider "aws" {
  region      = var.aws_region
  max_retries = 1
}

module "VPC" {
  source       = "./VPC"
  aws_region   = var.aws_region
  stage_name   = var.stage_name
  project_name = var.project_name
}
