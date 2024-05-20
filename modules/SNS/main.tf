resource "aws_sns_topic" "this" {
  name = "${var.project_name}-${var.stage_name}-topic"
  tags = var.tags
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "sns_sub_email" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.notification_email
}