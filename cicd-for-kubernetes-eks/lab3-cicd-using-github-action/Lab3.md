# CI/CD Pipeline Guide for AWS EKS Using GitHub Actions

This guide will walk you through implementing a complete CI/CD pipeline using **GitHub Actions** to deploy your full-stack mono-repository (frontend & backend) to an AWS EKS (Elastic Kubernetes Service) cluster.

Since your app already runs successfully on Minikube locally (`minikube-local.yaml`), we will replicate that structure but target EKS using the `aws-eks.yaml` configuration.

---

## 🏗️ Architecture Overview

1. **GitHub**: Stores your source code repository (`/frontend`, `/backend`) and configuration files.
2. **GitHub Actions**: Orchestrates the CI/CD workflow. It automatically triggers on code pushes, compiles the code, builds Docker images for both backend and frontend, and pushes them to Amazon ECR (Elastic Container Registry).
3. **AWS EKS**: The deployment target. GitHub Actions will securely authenticate with AWS, update the `kubeconfig`, and run `kubectl apply` to deploy your application components to the EKS cluster.

---

## 📌 Prerequisites

- **AWS EKS cluster**: You must have an active EKS cluster (e.g., `devops-test-cluster`) and it must be accessible from GitHub Actions via AWS Credentials.
- **GitHub Repository**: Your code must be hosted on GitHub.
- **AWS IAM User/Role**: An IAM identity with permissions to access ECR and EKS. You will need the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for this user, or use OIDC.

---

## 📌 Step 1: Source Control with GitHub

If your code is not already on GitHub, you need to push it there.

1. Go to GitHub and create a new repository (e.g., `todo-app-monorepo`).
2. Initialize and push your code from your local machine:
```bash
git add .
git commit -m "Initial commit for EKS deployment via GitHub Actions"
git push -u origin master
```

---

## 📌 Step 2: Create Amazon ECR Repositories

You will need AWS Elastic Container Registry (ECR) repositories to hold the frontend and backend Docker images.

1. Navigate to the **Amazon ECR** console in AWS.
2. Create two private repositories:
   - `todo-app-frontend`
   - `todo-app-backend`

*Note the repository names, as you will need them in your workflow.*

---

## 📌 Step 3: Configure GitHub Secrets

To allow GitHub Actions to securely interact with your AWS account, you need to configure repository secrets.

1. In your GitHub repository, go to **Settings** > **Secrets and variables** > **Actions**.
2. Click **New repository secret** and add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your IAM user's access key.
   - `AWS_SECRET_ACCESS_KEY`: Your IAM user's secret key.
   - `AWS_REGION`: The AWS region where your EKS and ECR are located (e.g., `ap-southeast-1`).
   - `EKS_CLUSTER_NAME`: The name of your EKS cluster (e.g., `devops-test-cluster`).

*(Note: It is highly recommended to use IAM Roles with OIDC instead of long-lived access keys for better security)*

---

## 📌 Step 4: Create the GitHub Actions Workflow

You need to define the CI/CD pipeline in a YAML file inside the `.github/workflows` directory of your repository.

1. At the root of your project, create the following directory structure: `.github/workflows/`
2. Inside the `workflows` directory, create a file named `deploy.yml`.
3. Add the following content to `.github/workflows/deploy.yml`:
* See deploy.yml file for example.

---

## 📌 Step 5: Trigger the CI/CD Pipeline

To trigger the pipeline, simply make a change to your codebase and push it to the `master` branch.

```bash
git add .
git commit -m "Update application and workflow"
git push origin master
```

Once pushed, go to the **Actions** tab in your GitHub repository. You should see your `Deploy to EKS` workflow running. Click on it to view the real-time logs of the build and deployment process.

---

## 🎉 Success Validation

After the GitHub Actions workflow successfully completes, validate the deployment in your EKS cluster from your local terminal:

```bash
# Update your local kubeconfig if you haven't already
aws eks update-kubeconfig --name devops-test-cluster --region ap-southeast-1

# Check the status of your resources
kubectl get deployments
kubectl get pods
kubectl describe pod <pod-name>
kubectl get svc
kubectl get ingress
```

Wait until the ALB is provisioned and access your application via the Ingress Address or LoadBalancer URL based on the output of `kubectl get ingress` or `kubectl get svc`.

---

## 🧹 Clearing Resources (Hoặc sử dụng để làm luôn bài lab 4)

1. Delete EKS Cluster:
```bash
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1
```
2. Delete ECR repositories.
3. Delete GitHub Secrets.
4. Delete Application Load Balancer.
