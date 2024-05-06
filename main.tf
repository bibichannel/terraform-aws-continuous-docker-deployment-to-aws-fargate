locals{
  tags = {
    Project = var.project_name
    CreateBy = var.create_by
    CreateOn = timestamp()
    Environment = var.stage_name
  }
}

module "VPC" {
  source         = "./modules/VPC"
  aws_region     = var.aws_region
  project_name   = var.project_name
  stage_name     = var.stage_name
  container_port = var.container_port
  tags = local.tags
}

module "ALB" {
  source             = "./modules/ALB"
  project_name       = var.project_name
  stage_name         = var.stage_name
  vpc_id             = module.VPC.vpc_id
  public_subnet_1_id = module.VPC.public_subnet_1_id
  public_subnet_2_id = module.VPC.public_subnet_2_id
  sg_alb_id          = module.VPC.sg_alb_id
  tags = local.tags
}