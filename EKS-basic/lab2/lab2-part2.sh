#Yêu cầu: Sử dụng ALB làm LoadBalancer cho service.
#Yêu cầu: Sử dụng lại resource đã triển khai tại bài lab-3-part-1
#Tạo thêm config cho Ingress với path /api ->backend và / -> frontend
#Apply config cho EKS Cluster
#Truy cập thử thông qua ALB.

#==Step1: Tạo một file config bao gồm các hạng mục:
# - Deployment cho Frontend
# - Service cho Frontend
# - Deployment cho Backend
# - Service cho Backend
# - Ingress sử dụng ALB

#Chi tiết tham khảo file demo-app.yaml


#==Step2: Apply file config
kubectl apply -f demo-app.yaml

#==Step3: Kiểm tra các resource đã được tạo ra
kubectl get deployment
kubectl get service
kubectl get ingress

#==Step4: Truy cập ứng dụng thông qua DNS của ALB

#==Step5: Xoá resource [Optional nếu các bạn không muốn tiếp tục sử dụng]
kubectl delete -f demo-app.yaml
