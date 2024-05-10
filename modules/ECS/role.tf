################ Create role for Task definitions ##################
data "aws_iam_policy_document" "task_exec_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "task_exec_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "task_exec_role" {
  name               = "${var.project_name}-${var.stage_name}-task-exec-role"
  assume_role_policy = data.aws_iam_policy_document.task_exec_assume_role.json
}

resource "aws_iam_role_policy" "task_exec_policy" {
  name   = "task_exec_policy"
  role   = aws_iam_role.task_exec_role.id
  policy = data.aws_iam_policy_document.task_exec_policy.json
}