#!/bin/bash

cat <<EOF >> terraform.tfvars
aws_region="$AWS_REGION"
project_name="$PROJECT_NAME"
stage_name="$STAGE_NAME"
create_by="$GITHUB_ACTOR"
github_repo="$GITHUB_REPOSITORY"
github_branch="main"
codestar_connection_arn="$CODESTAR_CONNECTION_ARN"
container_port=$CONTAINER_PORT
EOF

cat <<EOF >> vars.tfbackend
bucket="$TERRAFORM_BUCKET_NAME"
key="terraform-$STAGE_NAME/terraform.tfstate"
region="$AWS_REGION"
EOF