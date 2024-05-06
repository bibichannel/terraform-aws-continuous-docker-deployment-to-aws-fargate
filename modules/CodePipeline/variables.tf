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
variable "s3_artifact_bucket" {
  description = "S3 artifact bucket"
  type = string
}

variable "s3_artifact_bucket_arn" {
  description = "The ARN of S3 artifact bucket"
  type = string
}

################ Variables for github ##################
variable "github_owner" {
  description = "Github owner"
  type = string
}

variable "github_repo" {
  description = "Full repository name"
  type = string
}

variable "github_branch" {
  description = "Branch of github repo"
  type = string
}

variable "github_token" {
  description = "The github webhook secret"
  type = string
}

################ Variables for Codebuild ##################
variable "codbuild_name" {
  description = "The name of CodeBuild project"
  type = string
}