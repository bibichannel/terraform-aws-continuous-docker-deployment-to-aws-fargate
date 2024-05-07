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
  }

  tags = var.tags
}