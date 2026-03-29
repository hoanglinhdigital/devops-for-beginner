# CI/CD Pipeline Guide for AWS EKS

This guide will walk you through implementing a complete CI/CD pipeline using AWS CodeCommit, CodeBuild, CodeDeploy, and CodePipeline to deploy your full-stack mono-repository (frontend & backend) to an AWS EKS (Elastic Kubernetes Service) cluster. 

Since your app already runs successfully on Minikube locally (`minikube-local.yaml`), we will replicate that structure but target EKS.

---
## Repository to be used:
https://github.com/hoanglinhdigital/react-express-mongodb

## Prerequisites
- AWS EKS cluster: Create a simple EKS cluster using eksctl and connect to it successfully.

## 🏗️ Architecture Overview

1. **AWS CodeCommit**: Stores your monolithic source code repository `/frontend`, `/backend`, and configuration files (like `minikube-local.yaml` adapted for EKS).
2. **AWS CodeBuild**: Compiles the code, builds Docker images for both backend and frontend, and pushes them to Amazon ECR (Elastic Container Registry).
3. **AWS CodePipeline**: Orchestrates the workflow, detecting source code changes in CodeCommit and automatically triggering the build and deployment.
4. **Deploy Stage / AWS CodeDeploy**: While AWS CodeDeploy natively targets EC2, ECS, and Lambda, deployments to EKS through AWS CodePipeline are typically handled by defining a "Deploy" stage using an additional **CodeBuild** project that runs `kubectl apply` or uses a Helm chart to update the EKS cluster safely.

---

## 📌 Step 1: Source Control with AWS CodeCommit

Since you are using a **monorepo** approach, both `/frontend` and `/backend` will live in the same repository.

### Configuration Details:
1. Navigate to **AWS CodeCommit** in the AWS Console.
2. Click **Create repository**.
3. Name it `todo-app-monorepo` with a descriptive, optional description.
4. Clone the repository to your local machine:
   ```bash
   git clone https://git-codecommit.<region>.amazonaws.com/v1/repos/todo-app-monorepo
   ```
5. Move your existing files (`/frontend`, `/backend`, `minikube-local.yaml`) into this newly cloned repository directory.
6. Make a push to the master branch:
   ```bash
   git add .
   git commit -m "Initial commit for EKS deployment"
   git push origin master
   ```

---

## 📌 Step 2: Create two ECR repositories

You will need AWS Elastic Container Registry (ECR) repositories to hold the frontend and backend Docker images.
1. Create two ECR Repositories: `todo-app-frontend` and `todo-app-backend`.

Next, create a `buildspec.yml` file in the root of your repository to instruct CodeBuild on how to containerize and push the applications.

See `buildspec.yml` file for example.

*Make sure your CodeBuild IAM Role has the necessary permissions for ECR (`Action: ecr:*`).*

---
## 📌 Step 3: Orchestration with AWS CodePipeline

Lastly, tie the previous steps together using AWS CodePipeline.

1. Navigate to **CodePipeline** and click **Create Pipeline**.
2. **Name**: `todo-app-eks-pipeline`.
3. **Service Role**: Let it create a new service role.
4. **Source Stage**: 
   - Provider: **AWS CodeCommit**.
   - Repository: `todo-app-monorepo`.
   - Branch: `main`.
   - Output artifact format: `Full clone` *(Required to use git commands in CodeBuild)*.
5. **Build Stage**:
   - Provider: **AWS CodeBuild**.
   - Region: `Singapore`
   - Input Artifacts: "SourceArtifact"
   - Project Name: `todo-app-build-stage`
   - Build type: `Single`
   - Environment: 
     - Model: On-demand
     - Environment Image: Managed Image
     - Compute: EC2
     - Running Mode: Container
     - Operating System: Amazon Linux
     - Runtime: Standard
     - Image: aws/codebuild/amazonlinux2-x86-standard:5.0
     - Image version: Always use the latest image...
     - Service role: New service role. Choose a Role Name.
   - Privileged: Enable this flag if you want to build Docker images or want your builds to get elevated privileges
   - Additional Configuration
     - Environment variables
       - AWS_ACCOUNT_ID: [YOUR_AWS_ACCOUNT_ID]
       - AWS_DEFAULT_REGION: [YOUR_AWS_REGION]
   - Buildspec: `Usse a buildspec file`, type: `buildspec.yml`.
   - Artifacts: Choose `No Artifact`
   - 
6. **Test Stage**:
   - Choose Skip Test stage.
7. **Deploy Stage**:
   - Action Name: `Deploy to EKS`
   - Provider: **Amazon EKS**.
   - Region: `Singapore`
   - Input Artifacts: "BuildArtifact"
   - Cluster: Select your EKS cluster: `devops-test-cluster`
   - Namespace (Optional): Select the namespace where you want to deploy your application: `default`
   - Deploy configuration type: `kubectl`
   - Manifest file paths: `aws-eks.yaml`
   - Subnet ID: Select all **Private Subnets**. *NOTE: DO NOT SELECT PUBLIC SUBNETS*
   - Security Group ID: Select all Security Groups associated with your EKS cluster.

8. Click **Create** to initialize your pipeline. 

9. Add additional IAM Policy for CodeBuild Service Role
   - AmazonEC2ContainerRegistryFullAccess
   - AWSCodeCommitFullAccess
10. Add additional IAM Policy for CodePipeline Service Role
    - AmazonEC2ContainerRegistryFullAccess
    - AWSCodeCommitFullAccess
    - AWSCodeBuildDeveloperAccess
    - CloudWatchLogsFullAccess
    - AmazonEC2FullAccess
    - Cusstom policy for EKS Describe cluster:
    ```json
{
   "Version": "2012-10-17",
   "Statement": [
      {
            "Effect": "Allow",
            "Action": [
               "eks:DescribeCluster"
            ],
            "Resource": "*"
      }
   ]
}
    ```

11. Add Cluster role for CodePipeline Service Role
```bash
# 1. Create the access entry
aws eks create-access-entry \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::586098608758:role/service-role/Udemy-CodePipeline-Servicerole-20260322 \
  --type STANDARD

# 2. Associate an access policy
aws eks associate-access-policy \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::586098608758:role/service-role/Udemy-CodePipeline-Servicerole-20260322 \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy \
  --access-scope type=cluster
# 3. Verify
aws eks list-associated-access-policies \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::586098608758:role/service-role/Udemy-CodePipeline-Servicerole-20260322
```

12. Modify Security group to allow port 3000.


---
## 📌 Step 4: Modify code of TODO app backend and frontend to trigger CICD
```bash
git add .
git commit -m "Update TODO app backend and frontend v2"
git push origin master
```
## 🎉 Success Validation
Once you commit to the Main branch, your CI/CD Pipeline will automatically trigger. You can validate the deployment in your EKS cluster with:
```bash
kubectl get deployments
kubectl get pods
kubectl get svc
```
Your Ingress or LoadBalancer will then route traffic to the newly spun-up Monorepo applications!


## Clear resource (Hoặc sử dụng luôn cho bài lab 3)
1. Delete EKS Cluster
```bash
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1
```
2. Delete CodePipeline
3. Delete CodeBuild
4. Delete CodeCommit
5. Delete ECR repositories
6. Delete IAM Role
7. Delete Application Load Balancer