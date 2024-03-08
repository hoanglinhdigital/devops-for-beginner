#Tạo một EC2 chạy Ubuntu

#Cài đặt AWS CLI:
sudo apt update
sudo apt install awscli -y
aws --version
#cấp cho Kops instance quyền iam role có policy: AdministratorAccess.

#Cài đặt Kubectl & Kops cho server.
#Tham khảo link sau:
#https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl help

#Cài đặt Kops
#Tham khảo link sau: https://kops.sigs.k8s.io/getting_started/install/
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops
kops version

#Chuẩn bị domain, có thể mua tại Route53.
#Kiểm tra domain:
nslookup -type=ns hoanglinhdigital.com

#Tạo một S3 bucket để lưu trữ state của Kops
aws s3api create-bucket --bucket udemy-devops-kops --region ap-southeast-1

#Tạo cluster = KOPS command
kops create cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --zones=ap-southeast-1a,ap-southeast-1c --node-count=2 --node-size=t3.small --master-size=t3.small --dns-zone hoanglinhdigital.com --node-volume-size=10 --master-volume-size=10

#Apply thay đổi thực sự:
kops update cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --yes --admin

#Validate cluster:
kops validate cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --wait 10m

#getnode:
kubectl get nodes

#output as below is OK
NODE STATUS
NAME                    ROLE            READY
i-03ee28b8c4c2fd0cb     node            True
i-04b3c3d35f590fc60     control-plane   True
i-0cdc0ec740ecf6504     node            True

#kiểm tra Kubenetes config file được tạo ra:
cat ~/.kube/config

#Copy các item trong config và paste vào file ~/.kube/config trên máy local.
#Đối với Windows: C:\Users\{username}\.kube\config

#Kiểm tra thông tin cluster:
kubectl cluster-info
kubectl get nodes



#LƯU Ý: Xoá Cluster nếu không sử dụng đến để tránh tốn phí:
kops delete cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --yes