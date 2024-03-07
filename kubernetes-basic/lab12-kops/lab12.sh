#Tạo một EC2 chạy Ubuntu

#Cài đặt Brew
#Sử dụng Brew dể cài Kops và Kubectl
brew update && brew install kops kubectl

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


#Tạo một S3 bucket để lưu trữ state của Kops
aws s3api create-bucket --bucket udemy-devops-kops --region ap-southeast-1

#Tạo cluster = KOPS command
kops create cluster --name=kubevpro.groophy.in \ 
--state=s3://udemy-devops-kops --zones=ap-southeast-1a,ap-southeast-1c \ 
--node-count=2 --node-size=t3.small --master-size=t3.small --dns-zone=hoanglinhdigital.com \ 
--node-volume-size=8 --master-volume-size=8

kops update cluster --name kubevpro.groophy.in --state=s3://udemy-devops-kops --yes --admin

kops delete cluster --name kubevpro.groophy.in --state=s3://udemy-devops-kops --yes --admin