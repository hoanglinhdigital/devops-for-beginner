# Yêu cầu:
# Tạo một file cấu hình cho nginx service dạng NodePort (kèm theo deployment).
# Apply file cấu hình cho Kubernetes cluster.
# Kiểm tra Service & Deployment được tạo ra.
# Sử dụng câu lệnh sau để check IP của minikube, open địa chỉ <minikube_ip>:<node_port> trên trình duyệt để xem kết quả.
>minikube ip
#==================
# Create a file named nginx-nodeport.yaml
# Apply the configuration file to the Kubernetes cluster
kubectl apply -f nginx-nodeport.yaml
# Check the Service & Deployment
kubectl get service
kubectl get service nginx-service -o wide
kubectl get deployment
kubectl get pods -o wide

#Kiểm tra IP của minikube
minikube ip
#Lưu ý: Địa chỉ này chỉ có tác dụng trọng mạng nội bộ của Kubernetes, không thể truy cập từ bên ngoài.

#Cần phải sử dụng câu lệnh tạo một tunnel để có thể truy cập từ bên ngoài
minikube service nginx-service --url
#Copy URL dán vào trình duyệt, vd:
http://127.0.0.1:64451

#Xoá resource:
kubectl delete -f nginx-nodeport.yaml

