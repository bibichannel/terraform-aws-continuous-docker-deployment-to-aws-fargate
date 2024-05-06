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
  type = string
}

################ Variables for S3 ##################
variable "s3_artifact_bucket_arn" {
  description = "The ARN of S3 artifact bucket"
  type = string
}