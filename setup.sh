#!/bin/bash

cat <<EOF >> terraform.tfvars
# Variables pass from host's environment
aws_region="$AWS_REGION"
create_by="$GITHUB_ACTOR"
account_id="$AWS_ACCOUNT_ID"

# Variables pass from workflow action, define in workflow file.
project_name="$PROJECT_NAME"
stage_name="$STAGE_NAME"
github_repo="$YOUR_GITHUB_REPOSITORY"
github_branch="$YOUR_GITHUB_BRANCH"
codestar_connection_arn="$CODESTAR_CONNECTION_ARN"
EOF

cat <<EOF >> vars.tfbackend
bucket="$TERRAFORM_BUCKET_NAME"
key="terraform-$STAGE_NAME/terraform.tfstate"
region="$AWS_REGION"
EOF