locals {
  tags = {
    Project     = var.project_name
    CreateBy    = var.create_by
    Environment = var.stage_name
  }
  enable_nat_gateway    = false
  enable_application_lb = true
}

module "VPC" {
  source             = "./modules/VPC"
  tags               = local.tags
  aws_region         = var.aws_region
  project_name       = var.project_name
  stage_name         = var.stage_name
  container_port     = var.container_port
  enable_nat_gateway = local.enable_nat_gateway
}

module "ALB" {
  source                = "./modules/ALB"
  tags                  = local.tags
  enable_application_lb = local.enable_application_lb
  project_name          = var.project_name
  stage_name            = var.stage_name
  vpc_id                = module.VPC.vpc_id
  public_subnet_1_id    = module.VPC.public_subnet_1_id
  public_subnet_2_id    = module.VPC.public_subnet_2_id
  sg_alb_id             = module.VPC.sg_alb_id
  container_port        = var.container_port
}

module "S3" {
  source       = "./modules/S3"
  tags         = local.tags
  project_name = var.project_name
  stage_name   = var.stage_name
}

module "ECR" {
  source       = "./modules/ECR"
  tags         = local.tags
  project_name = var.project_name
  stage_name   = var.stage_name
}

module "CloudWatch" {
  source       = "./modules/CloudWatch"
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
  ecr_repository_url     = module.ECR.ecr_repository_url
  codebuild_lg_name      = module.CloudWatch.codebuild_cloudwatch_log_group_name
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
  cluster_name            = module.ECS.cluster_name
  ecs_service_name        = module.ECS.ecs_service_name
}

module "ECS" {
  source                   = "./modules/ECS"
  tags                     = local.tags
  aws_region               = var.aws_region
  project_name             = var.project_name
  stage_name               = var.stage_name
  private_subnet_1_id      = module.VPC.private_subnet_1_id
  private_subnet_2_id      = module.VPC.private_subnet_2_id
  sg_ecs_tasks_id          = module.VPC.sg_ecs_tasks_id
  container_name           = var.container_name
  container_cpu            = var.container_cpu
  container_memory         = var.container_memory
  container_port           = var.container_port
  repository_url           = module.ECR.ecr_repository_url
  ecs_fargate_task_lg_name = module.CloudWatch.ecs_task_cloudwatch_log_group_name
  target_group_arn         = module.ALB.target_group_arn
}