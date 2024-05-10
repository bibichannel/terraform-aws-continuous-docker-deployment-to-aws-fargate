resource "aws_ecr_repository" "terraform_ecr_repository" {
  name                 = "streamlit-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  tags                 = var.tags
}

