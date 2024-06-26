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

################ Variables for ECS ##################
variable "container_port" {
  description = "Container port"
  type        = number
}