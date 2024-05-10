resource "aws_codebuild_project" "terraform_codebuild" {
  name         = "${var.project_name}-${var.stage_name}-codebuild"
  description  = "Build docker images for project streamlit app"
  service_role = aws_iam_role.codepbuild_role.arn

  source {
    type                = "CODEPIPELINE"
    buildspec           = "buildspec.yml"
    report_build_status = "false"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    privileged_mode = true

    environment_variable {
      name  = "REPOSITORY_URL"
      value = var.ecr_repository_url
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.codebuild_lg_name
      stream_name = "codebuild"
    }
  }

  tags = var.tags
}