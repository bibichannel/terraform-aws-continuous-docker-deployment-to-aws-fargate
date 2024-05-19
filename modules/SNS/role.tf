data "aws_iam_policy_document" "codebuild_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "codebuild_policy" {

  statement {
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = [
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

resource "aws_iam_role" "codepbuild_role" {
  name               = "${var.project_name}-${var.stage_name}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.project_name}-${var.stage_name}-codebuild-policy"
  role   = aws_iam_role.codepbuild_role.id
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

