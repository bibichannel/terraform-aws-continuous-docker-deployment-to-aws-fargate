################ Variables for global ##################
variable "tags" {
  description = "Tag map for the resource"
  type        = map(string)
  default     = {}
}

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

################ Variables for VPC ##################
variable "private_subnet_1_id" {
  description = "Id of public subnet 1"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Id of public subnet 2"
  type        = string
}

variable "sg_ecs_tasks_id" {
  description = "The security group id for application LB"
  type        = string
}

################ Variables for ECR ##################
variable "repository_url" {
  description = "The ECR's URL"
  type        = string
}

################ Variables for ECS ##################
variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "container_cpu" {
  description = "The container cpu unit"
  type        = number
}

variable "container_memory" {
  description = "The container memory unit"
  type        = number
}

################ Variables for Cloudwatch ##################
variable "ecs_fargate_task_lg_name" {
  description = "The log group name of cloudwatch for ECS task definitions"
  type        = string
}
