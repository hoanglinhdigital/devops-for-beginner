#Yêu cầu: Tạo một EKS Cluster và kết nối tới.
#==========Phương án sử dụng AWS Console==========
#Các bạn có thể tham khảo guide sau:
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html


#==========Phương án sử dụng EKSCTL==========
#Guide hướng dẫn gốc của AWS: 
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
#Yêu cầu máy các bạn đã cài sẵn các tool:
- aws cli (Chú ý không sử dụng version quá cũ!)
- kubectl #Link: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
- eksctl  #Link cài eksctl cho windows: https://eksctl.io/installation/
- helm    #https://helm.sh/docs/intro/install/
#NOTE: các bạn nên sử dụng chocolatey để cài eksctl & kubectl & helm cho windows.
#Kiểm tra version:
aws --version
kubectl version --client
eksctl version
helm version --short

#===Step 1: Tạo EKS Cluster===
#Kiểm tra IAM user đã có quyền tạo EKS Cluster
aws sts get-caller-identity

#Tạo cluster có sẵn node group.
#Quá trình tạo cluster sẽ mất ~10 phút.
cd EKS-basic/lab1
#Chỉnh sửa file cluster-config.yaml nếu muốn thay đổi tên cluster, region, số lượng node, loại instance...
#Chạy lệnh tạo cluster
eksctl create cluster -f cluster-config.yaml

#Chạy lệnh sau để disable extended support cho EKS (giúp tiết kiệm chi phí):
aws eks update-cluster-config --name devops-test-cluster --upgrade-policy supportType=STANDARD

#===Step 2: Chạy lệnh sau để update file config trong thư mục ~/.kube/config (Đối với windows là: C:\Users\{username}\.kube\config)
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

#Check context
kubectl config get-contexts
#[Optional] Set context nếu có nhiều cluster và current context chưa đúng.
kubectl config use-context devops-test-cluster

#Get cluster info
kubectl cluster-info
#Kết quả:
Kubernetes control plane is running at https://<8945378295HFEHFJRHEIWUO7549283>.gr7.ap-southeast-1.eks.amazonaws.com
CoreDNS is running at https://<8945378295HFEHFJRHEIWUO7549283>.gr7.ap-southeast-1.eks.amazonaws.com/api/v1/

#===Step 3: Tạo node group gồm 2 node t3.medium 
# LƯU Ý: Bỏ qua bước tạo node-group này nếu đã tạo cluster có node group ở trên
eksctl create nodegroup --cluster=devops-test-cluster --region=ap-southeast-1 --name=my-node-group --node-type=t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --managed

#===Step 4: Đợi khoảng 5 phút, kiểm tra node
kubectl get nodes

#Kết thúc bài lab, các bạn đã tạo thành công một EKS Cluster và kết nối tới nó.

