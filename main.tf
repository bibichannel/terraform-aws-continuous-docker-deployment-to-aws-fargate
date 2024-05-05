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
  source         = "./modules/VPC"
  aws_region     = var.aws_region
  project_name   = var.project_name
  stage_name     = var.stage_name
  container_port = var.container_port
}

module "ALB" {
  source             = "./modules/ALB"
  project_name       = var.project_name
  stage_name         = var.stage_name
  vpc_id             = module.VPC.vpc_id
  public_subnet_1_id = module.VPC.public_subnet_1_id
  public_subnet_2_id = module.VPC.public_subnet_2_id
  sg_alb_id          = module.VPC.sg_alb_id
}