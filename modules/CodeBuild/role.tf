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
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]
    resources = [
      var.s3_artifact_bucket_arn,
      "${var.s3_artifact_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = ["sns:Publish"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

}

resource "aws_iam_role" "codepbuild_role" {
  name               = "${var.project_name}-${var.stage_name}-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role.json
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.project_name}-${var.stage_name}-codebuild-policy"
  role   = aws_iam_role.codepbuild_role
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

