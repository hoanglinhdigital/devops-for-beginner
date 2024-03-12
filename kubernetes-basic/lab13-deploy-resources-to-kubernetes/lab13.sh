#Yêu cầu: Đã làm xong bài lab số 12, tạo Cluster thành công.
#Kiểm tra một lần nữa trạng thái của Cluster:
kubectl cluster-info
kubectl get nodes

#Nếu bị outdate credential, chạy lại lệnh sau trên server kops:
kops update cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --yes
kops export kubecfg --name=hoanglinhdigital.com --state=s3://udemy-devops-kops
#Kết quả:
#kOps has set your kubectl context to hoanglinhdigital.com
#[Optional] nếu bạn muốn thao tác với cluster từ máy local, hãy copy file ~/.kube/config từ server kops về máy local.

#===Step1: Checkout repository sau (hoặc bất cứ project docker compose nào bạn thích):
https://github.com/docker/awesome-compose
#Repository bao gồm rất nhiều bài lab, ở đây mình chọn bài lab trong thư mục này để hướng dẫn các bạn:
react-express-mongodb

#*Repository backup cho trường hợp repo bên trên bị xóa:
https://github.com/hoanglinhdigital/awesome-compose

#Step2: Chạy thử bằng lệnh Docker Compose
cd react-express-mongodb
docker-compose up -d
#Kiểm tra trạng thái các container:
docker-compose ps
#Truy cập thử vào localhost:3000
#Nếu chạy OK ta mới tiến hành step tiếp theo.

#===Step3: Tạo một repository trong GitHub, tên là react-express-mongodb
#Clone repository về máy:
#Copy toàn bộ nội dung của thư mục react-express-mongodb vào thư mục vừa clone về.
#Push lên GitHub.

#===Step4: Build các Docker image và push lên ECR.
# - Tạo các ECR repositories cho các image
# - Build các image và push lên ECR

#===Step5: Tạo các file kubernetes config cho các resource
# - Tạo file kubernetes config cho React-Backend
# - Tạo file kubernetes config cho Express-Frontend
# - Tạo file kubernetes config cho MongoDB
# - Tạo file kubernetes config cho LoadBalancer (Sử dụng ALB Ingress Controller)

#===Step6: Deploy các resource lên Kubernetes theo thứ tự sau:
# - Deploy MongoDB
# - Deploy Express-Backend
# - Deploy React-Frontend
# - Deploy LoadBalancer 

#===Step7: Kiểm tra trạng thái của các resource
# - Kiểm tra trạng thái của các Pod
kubectl get pods
# - Kiểm tra trạng thái của các Service
kubectl get services
# - Kiểm tra trạng thái của các Deployment
kubectl get deployments
# - Kiểm tra trạng thái của các Ingress
kubectl get ingress

#===Step8: Truy cập vào ứng dụng thông qua LoadBalancer DNS

#===Step9: Xoá các resource
# - Xoá LoadBalancer
# - Xoá React-Frontend
# - Xoá Express-Backend
# - Xoá MongoDB

#===Step10: Xoá Cluster
kops delete cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --yes




#Note 2024-03-12 - Create AWS Load Balancer controller.
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=aws-load-balancer-webhook-service.kube-system.svc"
kubectl create secret generic aws-load-balancer-webhook-tls --from-file=tls.crt --from-file=tls.key -n kube-system
kubectl get secret aws-load-balancer-webhook-tls -n kube-system

# Kubernetes >= 1.15
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/v2_2_0_full.yaml

# Kubernetes < 1.15
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/v2_2_0_full_legacy.yaml

#Verify the deployment of the AWS Load Balancer Controller
kubectl get deployment -n kube-system aws-load-balancer-controller


##
helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=hoanglinhdigital.com -n kube-system
kubectl get deployment -n kube-system aws-load-balancer-controller

kubectl get deployment aws-load-balancer-controller -o yaml -n kube-system > test-2.yaml
#Modify test-2.yaml
#Add below lines:
      containers:
      - args:
        - --cluster-name=my-hoanglinhdigital.com
        - --ingress-class=alb
        - --aws-region=ap-southeast-1
        - --aws-vpc-id=vpc-005bcc5f352b57f1d



