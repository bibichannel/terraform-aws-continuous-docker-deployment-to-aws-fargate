locals {
  tags = {
    Project     = var.project_name
    CreateBy    = var.create_by
    Environment = var.stage_name
  }
}

module "VPC" {
  source         = "./modules/VPC"
  tags           = local.tags
  aws_region     = var.aws_region
  project_name   = var.project_name
  stage_name     = var.stage_name
  container_port = var.container_port

}

# module "ALB" {
#   source             = "./modules/ALB"
#   tags = local.tags
#   project_name       = var.project_name
#   stage_name         = var.stage_name
#   vpc_id             = module.VPC.vpc_id
#   public_subnet_1_id = module.VPC.public_subnet_1_id
#   public_subnet_2_id = module.VPC.public_subnet_2_id
#   sg_alb_id          = module.VPC.sg_alb_id

# }

module "S3" {
  source       = "./modules/S3"
  tags         = local.tags
  project_name = var.project_name
  stage_name   = var.stage_name
}

module "CodeBuild" {
  source                 = "./modules/CodeBuild"
  tags                   = local.tags
  project_name           = var.project_name
  stage_name             = var.stage_name
  s3_artifact_bucket_arn = module.S3.artifact_bucket_arn
}

module "CodePipeline" {
  source                  = "./modules/CodePipeline"
  tags                    = local.tags
  aws_region              = var.aws_region
  project_name            = var.project_name
  stage_name              = var.stage_name
  s3_artifact_bucket      = module.S3.artifact_bucket
  s3_artifact_bucket_arn  = module.S3.artifact_bucket_arn
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  terraform_codbuild_name = module.CodeBuild.terraform_codebuild_name
  terraform_codebuild_arn = module.CodeBuild.terraform_codebuild_arn
  codestar_connection_arn = var.codestar_connection_arn
}