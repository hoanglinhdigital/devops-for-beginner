## 🧹 Clearing Resources 

1. Delete EKS Cluster:
```bash
# Delte node group:
eksctl delete nodegroup --cluster devops-test-cluster --name my-nodes --drain=false --approve
# Delete cluster:
eksctl delete cluster --name devops-test-cluster --force --disable-nodegroup-eviction
```
2. Delete ECR repositories.
3. Delete GitHub Secrets, IAM Access Key.
4. Delete Application Load Balancer.
5. Delete EC2 instance (if remain).