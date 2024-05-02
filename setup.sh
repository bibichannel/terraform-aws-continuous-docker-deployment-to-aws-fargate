#!/bin/bash

cat <<EOF >> terraform.tfvars
aws_region="$AWS_REGION"
project_name="$PROJECT_NAME"
stage_name="$STAGE_NAME"
EOF

cat <<EOF >> vars.tfbackend
bucket="$TERRAFORM_BUCKET_NAME"
key="terraform-$STAGE_NAME/terraform.tfstate"
region="us-east-1"
EOF