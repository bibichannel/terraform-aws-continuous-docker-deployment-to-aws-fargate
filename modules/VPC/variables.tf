variable "stage_name" {
  description = "The stage name is run"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "The project name"
  type = string
}

variable "container_port" {
  description = "Container port"
  type = number
}