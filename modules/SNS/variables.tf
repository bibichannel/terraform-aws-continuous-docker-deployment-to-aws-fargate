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

####
variable "account_id" {
  description = "Account id of aws"
  type = string
}