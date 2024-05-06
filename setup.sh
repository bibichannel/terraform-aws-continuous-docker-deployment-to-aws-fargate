#!/bin/bash

cat <<EOF >> terraform.tfvars
aws_region="$AWS_REGION"
project_name="$PROJECT_NAME"
stage_name="$STAGE_NAME"
github_owner="$GITHUB_REPOSITORY_OWNER"
github_repo="$GITHUB_REPOSITORY"
github_branch="main"
github_token="$YOUR_GITHUB_TOKEN"
EOF

cat <<EOF >> vars.tfbackend
bucket="$TERRAFORM_BUCKET_NAME"
key="terraform-$STAGE_NAME/terraform.tfstate"
region="$AWS_REGION"
EOF