# Chuẩn bị 2 Docker image dạng Nodejs, đơn giản print ra message Service-A, Service-B, push image lên DockerHub.
# Tạo một File cấu hình bao gồm các thông số:
# Service A & Deployment_A
# Service B & Deployment_B
# File cấu hình ingress routing theo host: service-a.localhost, service-b.localhost
# Apply cấu hình cho Kubernetes cluster.
# Truy cập vào cluster thông qua ingress với sub domain:
# service-a.localhost
# service-b.localhost

#===================================
#Step1 checkout repo sau:
https://github.com/hoanglinhdigital/nodejs-random-color
#Step2 Build ra 2 image với thông số khác nhau
#  - Modify trang index để in ra message ServiceA
#  - Build docker image
docker build -t <your-dockerhub-account>/nodejs-random-color:service-a .
#Ví dụ:
docker build -t hoanglinhdigital/nodejs-random-color:service-a .
#  - Push lên DockerHub
docker push hoanglinhdigital/nodejs-random-color:service-a

#  - Modify trang index để in ra message ServiceB
#  - Build docker image
docker build -t <your-dockerhub-account>/nodejs-random-color:service-a .
#VD:
docker build -t hoanglinhdigital/nodejs-random-color:service-b .
#  - Push lên DockerHub
docker push hoanglinhdigital/nodejs-random-color:service-b
#Kiểm tra trên Dockerhub có 2 image đã được push lên chưa.

#Step3 Tạo file cấu hình yaml
#Tham khảo ingress-demo.yaml

#Step4 Apply cấu hình
kubectl apply -f ingress-demo.yaml

#Kiểm tra thông tin các resource
kubectl get all

#Step5 Enable ingress:
minikube addons enable ingress
#Chạy lệnh 
minikube tunnel

#Truy cập vào cluster thông qua ingress với 2 subdomain: service-a, service-b
#Truy cập vào trình duyệt và truy cập vào địa chỉ sau:
http://service-a.localhost
http://service-b.localhost

#Terminate resources
kubectl delete -f ingress-demo.yaml