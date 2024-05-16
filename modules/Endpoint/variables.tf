################ Variables for global ##################
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

variable "stage_name" {
  description = "The stage name is run"
  type        = string
}

variable "project_name" {
  description = "The project name"
  type        = string
}

################ Variables for VPC ##################
variable "vpc_id" {
  description = "The VPC id"
  type        = string
}

variable "private_subnet_1_id" {
  description = "Id of public subnet 1"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Id of public subnet 2"
  type        = string
}

variable "private_rtb_01_id" {
  description = "The id of private route table 01"
  type = string
}

variable "private_rtb_02_id" {
  description = "The id of private route table 01"
  type = string
}

variable "sg_ecr_endpoint_id" {
  description = "The id of security group ecr endpoint"
}