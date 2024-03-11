#Yêu cầu: Đã làm xong bài lab số 12, tạo Cluster thành công.
#Kiểm tra một lần nữa trạng thái của Cluster:
kubectl cluster-info
kubectl get nodes

#Nếu bị outdate credential, chạy lại lệnh sau trên server kops:
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




