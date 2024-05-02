provider "aws" {
  region      = var.aws_region
  max_retries = 1
}

terraform {
  backend "s3" {
  }
}

module "VPC" {
  source       = "./VPC"
  aws_region   = var.aws_region
  stage_name   = var.stage_name
  project_name = var.project_name
}
