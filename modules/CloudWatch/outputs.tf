output "codebuild_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.codebuild_cloudwatch_log_group.name
}

output "ecs_task_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.ecs_task_cloudwatch_log_group.name
}