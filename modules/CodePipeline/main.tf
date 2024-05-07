resource "aws_codepipeline" "terraform_pipeline" {
  name     = "${var.project_name}-${var.stage_name}-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_artifact_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      region           = var.aws_region
      output_artifacts = ["source_artifact"]

      configuration = {
        ConnectionArn        = var.codestar_connection_arn
        FullRepositoryId     = var.github_repo
        BranchName           = var.github_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_artifact"]
      output_artifacts = ["build_artifact"]
      version          = "1"

      configuration = {
        ProjectName = var.terraform_codbuild_name
      }
    }
  }

  tags = var.tags
}