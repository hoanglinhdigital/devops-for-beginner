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

#===Step1: Checkout repository sau:
https://github.com/hoanglinhdigital/react-express-mongodb

#===Step2: Chạy thử bằng lệnh Docker Compose
- Navigate to `frontend` folder, find `package.json_local` and copy line No 30 to file `package.json`  
 ```"proxy": "http://backend:3000"```  
 *Make sure to correct Json format.
- Step 2: Navigate to root level of the repository and run:
```docker-compose up -d```
- Step 3: Open browser `localhowst:3000` to test the app.
- Step 4: Now your app is ready to deploy to any environment like Minikube, EKS or Kubernetes.
- Step 5: Remove line 30 in `package.json` to avoid proxy error when deploy to K8s, EKS.
- Step 6: [Optional] Remove DockerCompose resources by running `docker-compose down --volumes`

#===Step3: Build các Docker image và push lên ECR.
# - Tạo các ECR repositories cho các image
# - Build các image và push lên ECR
#LƯU Ý cho phần frontend, các bạn chỉnh sửa file package.json và DELETE dòng proxy để tránh chạy lỗi trên Kubernetes.
"proxy": "http://backend:3000",


#===Step4: Tạo các file kubernetes config cho các resource
# - Tạo kubernetes config cho React-Backend
# - Tạo kubernetes config cho Express-Frontend
# - Tạo kubernetes config cho MongoDB
# - Tạo kubernetes config cho Ingress Nginx với 2 route /api -> backend và / -> frontend

#===Step5: Tạo Ingress Nginx Controller bằng cách tham khảo guide sau:
https://github.com/kubernetes/ingress-nginx/blob/main/docs%2Fdeploy%2Findex.md
#Keyword: Bare metal clusters
#Hoặc các bạn cũng có thể copy lệnh sau chạy luôn:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/baremetal/deploy.yaml
#Kiểm tra trạng thái của Ingress Nginx Controller
kubectl get services -n ingress-nginx
#Kết quả như sau là OK:
NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             NodePort    100.67.79.127    <none>        80:31646/TCP,443:31609/TCP   16s
ingress-nginx-controller-admission   ClusterIP   100.71.229.247   <none>        443/TCP                      15s

#===Step6: Deploy các resource lên Kubernetes
kubectl apply -f lab13.yaml

#===Step7: Kiểm tra trạng thái của các resource
# - Kiểm tra trạng thái của các Pod
kubectl get pods
# - Kiểm tra trạng thái của các Service
kubectl get services
# - Kiểm tra trạng thái của các Deployment
kubectl get deployments
# - Kiểm tra trạng thái của các Ingress
kubectl get ingress
kubectl describe ingress/ingress-nginx

#===Step8: Tạo LoadBalancer + Target Group
#Tạo một alb-security-group, rule HTTP:80 cho phép truy cập từ mọi nơi.
#Tạo một APplication Load Balancer, listerner port 80
#Tạo một target group type Instance, port HTTP:30927 (*số 30297 lấy từ câu lệnh kubectl get services -n ingress-nginx)
#Cấu hình security group của các instance cho phép truy cập từ alb-security-group (All traffic).
#Truy cập vào Load Balancer thông qua DNS, test ứng dụng.

#===Step9: Xoá các resource
# - Xoá LoadBalancer
# - Xoá Target Group
# - Xoá các resource trên Kubernetes bằng lệnh:
kubectl delete -f lab13.yaml

#===Step10: Xoá Cluster (chạy lệnh này trong KOPS admin server)
kops delete cluster --name hoanglinhdigital.com --state=s3://udemy-devops-kops --yes

#===Step11: Xoá Kops server hoặc stop nếu muốn sử dụng lại.