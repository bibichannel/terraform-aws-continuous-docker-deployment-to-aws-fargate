resource "aws_cloudwatch_event_rule" "codepipeline_event_rule" {
  name          = "codepipeline-notification"
  description   = "Capture each codepipeline running"
  force_destroy = true

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"]
    detail-type = ["CodePipeline Pipeline Execution State Change"]
    detail = {
      state = [{
        anything-but = ["STARTED"]
      }]
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "target_sns" {
  target_id     = "sns-tg"
  rule          = aws_cloudwatch_event_rule.codepipeline_event_rule.name
  arn           = var.sns_topic_arn
  force_destroy = true
}
