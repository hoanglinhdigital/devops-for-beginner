#Yêu cầu: Tạo một EKS Cluster và kết nối tới.
#LƯU Ý: EKS khá tốn tiền nên các bạn lưu ý sử dụng cẩn thận!!!
#Cấu hình yêu cầu: 2 nodes, 2vcpu, 4GB Ram (t3.medium).

# Step 1: Tạo một EKS Cluster
#Login vào AWS Console.
#Chọn EKS -> Create Cluster
#Chọn Cluster name: devops-test-eks-cluster
#Chọn Kubernetes version: 1.21
#Chọn VPC: default
#Chọn Subnets: Chọn tất cả các subnet
#Chọn Security group: default
#Chọn Service role: default
#Chọn Role for cluster: default
#Chọn Create

# Step 2: Tạo Node Group
#Chọn Node Group -> Create Node Group
#Chọn Node Group name: devops-test-eks-node-group
#Chọn Kubernetes version: 1.21
#Chọn Node IAM Role: default
#Chọn Node Group role: default
#Chọn Node Group type: On-demand
#Chọn AMI type: Amazon Linux 2
#Chọn Instance type: t3.medium
#Chọn SSH key pair: Chọn keypair của bạn.
#Chọn Subnets: Chọn tất cả các subnet
#Chọn Security group: default
#Chọn Create

# Step 3: Cấu hình kubectl
#Chạy lệnh sau để cấu hình kubectl:
aws eks --region us-west-2 update-kubeconfig --name devops-test-eks-cluster
#Kiểm tra kết quả:
kubectl get nodes
#Kết quả:
#NAME                                           STATUS   ROLES    AGE   VERSION


#Su dung eksctl:
eksctl create cluster --name devops-test-cluster --region ap-southeast-1 --without-nodegroup
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

#Check context
kubectl config get-contexts
#Set context to cluster:
kubectl config use-context devops-test-cluster
eksctl create nodegroup --cluster=devops-test-cluster --region=region-code --name=my-node-group --node-type=t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --managed