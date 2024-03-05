#Tạo một EC2 chạy Ubuntu

#Cài đặt Brew
#Sử dụng Brew dể cài Kops và Kubectl
brew update && brew install kops kubectl

aws configure

#Tạo một S3 bucket để lưu trữ state của Kops
aws s3api create-bucket --bucket kops-state-store-linh --region ap-southeast-1

export KOPS_CLUSTER_NAME=devops.cluster.demo
export KOPS_STATE_STORE=s3://kops-state-store-linh

kops create cluster --zones ap-southeast-1a,ap-southeast-1c ${KOPS_CLUSTER_NAME}

kops update cluster --name ${KOPS_CLUSTER_NAME} --yes