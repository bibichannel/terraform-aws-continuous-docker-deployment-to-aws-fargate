# AWS DevOps: Deploy

## Solution architecture
The following diagram shows the flow of events in the solution:

## Introduction

## AWS Key Components
The provided Terraform code leverages these AWS services to create an automated deployment pipeline for your application, ensuring scalability, reliability, and security throughout the process.

1. **Amazon Virtual Private Cloud (VPC):** Is a secure, isolated private cloud hosted.
2. **Amazon Subnets:** Public and private subnets within the VPC for isolating resources based on security requirements.
3. **Amazon Internet Gateway (IGW):** Provides internet connectivity to instances in the public subnets.
4. **Amazon NAT Gateway:** Enables instances in the private subnets to initiate outbound traffic to the internet while preventing incoming connections.
5. **Amazon Security Group (SG):** Defines inbound and outbound traffic rules to control network access to instances.
6. **Amazon Application Load Balancer (ALB):** Distributes incoming application traffic across multiple targets, such as Amazon ECS containers.
7. **Amazon ECS Cluster:** Manages containers using the AWS Fargate launch type, abstracting the underlying infrastructure.
8. **Amazon ECS Task Definition:** Specifies the parameters for running containers within an Amazon ECS service.
9. **Amazon Elastic Container Registry (ECR):** A fully managed Docker container registry that stores, manages, and deploys container images.
10. **Amazon IAM Roles and Policies:** Define permissions for different services, allowing them to interact securely.
11. **AWS CodeBuild Project:** Builds, tests, and packages your source code, producing a ready-to-deploy container image.
12. **AWS CodePipeline:** Creates an end-to-end CI/CD pipeline that automates the build, test, and deployment process.
13. **Amazon CloudWatch Event Rule:** Monitors changes in the CodeBuild build status and triggers notifications.
14. **Amazon SNS Topic:** Allows publishing and subscribing to notifications and messages.
15. **IAM Roles for CodePipeline and CodeBuild:** Provides permissions for the pipeline and build processes to access required resources.
16. **IAM Policies:** Define permissions for roles to access necessary AWS services and resources.

## Project Workflow
Here's the project workflow for the provided Terraform code that sets up a Continuous Docker Deployment to AWS Fargate from GitHub using Terraform:

1. **VPC and Networking:** Create a VPC with specified CIDR blocks, public and private subnets across availability zones, an IGW for public subnet communication, configure NAT Gateway for private subnet outbound communication and set up route tables for public and private subnets.
2. **Security Group:** Create a security group for the ALB. Allow incoming traffic on ports 80 and 5000 for the ALB. Allow all outbound traffic.
3. **Application Load Balancer (ALB):** Create an ALB with specified attributes and subnets and set up ALB target groups and listeners.
4. **Amazon ECS Cluster and Task Definition:** Create an ECS cluster, define an ECS task definition for the application, configure the container definition for the Flask app, an IAM policy for ECS task execution.
5. **IAM Roles and Policies for CodePipeline and CodeBuild:** Define IAM roles for CodePipeline and CodeBuild, IAM policies with necessary permissions for ECS, S3, CloudWatch Logs, and attach the policies to the respective roles.
6. **Amazon CodeBuild Project:** Set up an Amazon CodeBuild project, configure the project to build from the specified GitHub repository and define build environment, source, and artifacts.
7. **Amazon CodePipeline:** Create an Amazon CodePipeline with a source stage from GitHub, configure the source webhook for GitHub repository, create a build stage using the CodeBuild project and define an S3 artifact store.
8. **Amazon SNS Topic:** Create an Amazon SNS topic for CodeBuild notifications, configure topic policy to allow CloudWatch Events to publish to the topic and create an IAM role for CloudWatch Events.
9. **CloudWatch Events:** Set up a CloudWatch Events rule to capture CodeBuild state changes and define event pattern to capture IN_PROGRESS, SUCCEEDED, FAILED, and STOPPED states.
10. **CloudWatch Events Target and Notification:** Configure CloudWatch Events to target the SNS topic and subscribe the specified email address to the SNS topic for notifications.
11. **Amazon ECR Repository:** Create an ECR repository for Docker images.
12. **Docker Image Build and Push:** Use a local-exec provisioner to build and push the Docker image to the ECR repository.
13. **Deployment to Fargate with CodePipeline:** The CodePipeline deployment stage will automatically deploy the new Docker image to ECS Fargate and the application will be available through the ALB.

It's a comprehensive DevOps workflow that ensures continuous deployment of Docker applications to AWS Fargate while providing notifications and monitoring through SNS and CloudWatch.

## Getting Started 
### Prerequisites
Before we dive into the details of the deployment pipeline, make sure you have the following prerequisites in place:

- **AWS account**: With permissions to create resources specified in the code.
- **Fork GitHub Repo**: Fork and clone your own [Yris-ops/aws-devops-continuous-docker-deployment-to-aws-fargate](https://github.com/Yris-ops/aws-devops-continuous-docker-deployment-to-aws-fargate) GitHub repository.
- **GitHub Token**: Create an token in GitHub and provide access to the repo scopes.
- **Terraform**: Installed on your local machine.
- **Docker**: Installed on your local machine.

### Implementation 

Terraform: All the resource provisioning for this solution is written in a Terraform configuration, which is available in the GitHub repository.

### Deployment Steps

1. **Clone** this repo on the local machine.
2. **Modify** the necessary parameters in the variables.tf file to suit your needs, such as region, VPC parameters, GitHub token, nomenclatures, etc.
3. **Deploy** the Terraform configuration with the following command: `terraform init -backend-config="vars.tfbackend" && terraform apply --auto-approve`.
4. **Wait** 5 to 10 minutes until all resources are deployed.

### Test Deployment

## CleanUp Resources

## Conclusion
