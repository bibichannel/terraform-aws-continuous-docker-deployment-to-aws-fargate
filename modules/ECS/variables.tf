################ Variables for global ##################
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "stage_name" {
  description = "The stage name is run"
  type        = string
}

variable "project_name" {
  description = "The project name"
  type        = string
}

################ Variables for ALB ##################
variable "target_group_arn" {
  description = "The ARN of target group"
  type        = string
}
