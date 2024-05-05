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
  type = string
}

variable "target_group_arn" {
  description = "The ARN of target group"
  type = string
}

variable "container_definitions" {
  type = list(object({
    name = string
    image = string
    cpu = number
    memory = number
    environment = map(string)
    secrets = map(string)
    container_port = number
  }))
  description = "List of container definition assigned to ecs task"
}

variable "network_mode" {
  description = "Ecs network mode"
  type = string
  default = "awsvpc"
}

variable "launch_type" {
  description = "ECS launch type"
  type = object({
    type = string
    cpu = number
    memory = number
  })
  default = {
    type = "EC2"
    cpu = null
    memory = null
  }
}