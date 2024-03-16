#Yêu cầu tạo một user "developer01" mới và gán quyền cho user đó vào Cluster EKS.

#===Step 1: Tạo user developer01
#Quyền: PoweruserAccess
#Tạo sẵn một AccessKey cho user developer01
#Thử login vào  AWS Console với id/pw của developer01, tìm đến cluster, xem resource -> không thấy được do permission denied.

#===Step 2: Gán quyền cho user developer01 (Quay trở lại giao diện của user Admin)
#Truy cập vào EKS Cluster
#Chọn tab Access, kéo xuống khu vực [IAM access entries]
#Nhấn nút Create access entry
#Configure IAM access entry
#  - IAM principal ARN: dán arn của user developer01, vd: arn:aws:iam::123456789012:user/developer01
#  - Type chọn Standard
#Nhấn Next

#Add access policy - optional
#  - Access policies chọn AmazonEKSViewPolicy
#  - Access scope chọn Cluster
#  - Nhấn nút: Add policy
#Nhấn Next
#Review và nhấn nút [Create]

#===Step 3:
#Cấu hình aws cli để sử dụng user mới tạo (tạo thêm 1 profile developer01)
aws configure --profile developer01
#Check file config
[developer01]
aws_access_key_id = AAAAAAAAAAAAAAA
aws_secret_access_key = bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
#Kiểm tra profile:
aws sts get-caller-identity --profile developer01
#Kết quả:
{
    "UserId": "AIDAWIVVHVPNJTU7GKK72",
    "Account": "12456789012",
    "Arn": "arn:aws:iam::12456789012:user/developer01"
}
#===Step 4: Sử dụng eksctl để update config map
#Xoá file sau hoặc backup sang một chỗ khác:
"C:\Users\<user_name>\.kube\config"
#Linux/Macos: 
~/.kube/config

aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster --profile developer01
#Kiểm tra context
kubectl config get-contexts
kubectl cluster-info
#Step 3: Kiểm tra quyền của user developer01
kubectl get pods
kubectl get all -A
#Kết quả: Xem được các resource trong cluster
#[Optional] Quay trở lại console, truy cập vào EKS Cluster xem có thể xem được resource.

#===Step 5: Xoá user developer01 (Truy cập vào IAM)


#===Step 6: Khôi phục EKS config cho user Admin
aws sts get-caller-identity
#Kết quả hiện ra user Admin
{
    "UserId": "AIDAWIVVHVPNJTU7GKK72",
    "Account": "12456789012",
    "Arn": "arn:aws:iam::12456789012:user/linhnguyen.admin"
}
#Chạy lênh sau để update config map
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

#Kiểm tra context
kubectl config get-contexts
kubectl get all -A

#===Step 7: Xoá EKS Cluster:
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1