resource "aws_sns_topic" "this" {
  name = "${var.project_name}-${var.stage_name}-topic"
  tags = var.tags
}

