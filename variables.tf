variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "stage_name" {
  description = "Name of stage run [staging, prod]"
  default     = "staging"
  type        = string
}

variable "project_name" {
  description = "The project name"
  type        = string
}



