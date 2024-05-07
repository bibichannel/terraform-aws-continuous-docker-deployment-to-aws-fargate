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

variable "vpc_id" {
  description = "The VPC id"
  type        = string
}

variable "public_subnet_1_id" {
  description = "Id of public subnet 1"
  type        = string
}

variable "public_subnet_2_id" {
  description = "Id of public subnet 2"
  type        = string
}

variable "sg_alb_id" {
  description = "The security group id for application LB"
  type        = string
}