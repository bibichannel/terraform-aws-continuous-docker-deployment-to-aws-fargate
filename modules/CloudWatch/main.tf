################ Create log group for codebuild ##################
resource "aws_cloudwatch_log_group" "codebuild_cloudwatch_log_group" {
  name = "${var.project_name}-${var.stage_name}-codebuild"
  tags = var.tags
}

################ Create log group for ecs task difinitions ##################
resource "aws_cloudwatch_log_group" "ecs_task_cloudwatch_log_group" {
  name = "${var.project_name}-${var.stage_name}-task"
  tags = var.tags
}