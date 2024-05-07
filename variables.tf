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

variable "create_by" {
  description = "The user run code"
  type        = string
}

##################### Variables for gihub ####################
variable "github_repo" {
  description = "Full repository name"
  type        = string
}

variable "github_branch" {
  description = "Branch of github repo"
  type        = string
}
##################### Variables for ecs ####################
variable "container_port" {
  description = "Container port"
  type        = number
}

variable "codestar_connection_arn" {
  description = "The ARN of CodeStart connection Github thirdparty"
  type        = string
}