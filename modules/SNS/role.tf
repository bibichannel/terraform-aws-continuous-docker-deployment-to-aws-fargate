data "aws_iam_policy_document" "sns_topic_policy" {

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:AddPermission",
      "SNS:Subscribe"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [
        var.account_id,
      ]
    }

    resources = [
      aws_sns_topic.this.arn,
    ]
  }

}

