################ Variables for global ##################
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

################ Variables of SNS ##################
variable "sns_topic_arn" {
  description = "SNS topic's arn"
  type        = string
}