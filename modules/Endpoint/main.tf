# https://docs.aws.amazon.com/AmazonECR/latest/userguide/vpc-endpoints.html
# Amazon ECS tasks hosted on Fargate using Linux platform version 1.4.0 
# or later require both the com.amazonaws.region.ecr.dkr 
# and com.amazonaws.region.ecr.api Amazon ECR VPC endpoints 
# as well as the Amazon S3 gateway endpoint to take advantage of this feature

# com.amazonaws.REGION.s3
# com.amazonaws.REGION.ecr.dkr
# com.amazonaws.REGION.ecr.api


###################### Create S3 gateway endpoint ##########################
resource "aws_vpc_endpoint" "s3" {
  service_name = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id       = var.vpc_id
  route_table_ids = [var.private_rtb_01_id, var.private_rtb_02_id]
  tags = var.tags
}

###################### Create ECR DKR endpoint ##########################
# This endpoint is used for the Docker Registry APIs. 
# Docker client commands such as push and pull use this endpoint.

resource "aws_vpc_endpoint" "ecr_dkr_endpoint" {
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  vpc_id       = var.vpc_id
  private_dns_enabled = true
  security_group_ids = [var.sg_ecr_endpoint_id]
  subnet_ids = [var.private_subnet_1_id, var.private_subnet_2_id]
  tags = var.tags
}

###################### Create ECR API endpoint ##########################
# This endpoint is used for calls to the Amazon ECR API. 
# API actions such as DescribeImages and CreateRepository go to this endpoint.

resource "aws_vpc_endpoint" "ecr_api_endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [var.sg_ecr_endpoint_id]
  subnet_ids = [var.private_subnet_1_id, var.private_subnet_2_id]
  tags = var.tags
}