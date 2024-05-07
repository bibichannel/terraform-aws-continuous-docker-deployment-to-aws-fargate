###################### Create bucket for CodePipeline ##########################
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.project_name}-${var.stage_name}-artifact-2024"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.artifact_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}