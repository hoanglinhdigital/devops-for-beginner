#Yêu cầu:
#Cài đặt Docker desktop (bỏ qua nếu đã cài).

#Cài đặt Kubectl trên máy cá nhân.
    #Tham khảo link:
    https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
#Cài đặt Minikube trên máy cá nhân hoặc trên một máy ảo, EC2.
    #Tham khảo link: 
    https://minikube.sigs.k8s.io/docs/start/

#Chạy câu lệnh sau:
>kubectl get nodes
#Kết quả trả về:
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   84m   v1.27.4

#===Troubleshoot nếu kết quả trả về không phải là minikube, khả năng máy của bạn đang kết nối tới một cluster khác.===
#Kiểm tra xem máy của bạn đang kết nối tới cluster nào:
kubectl config get-contexts
#Kết quả trả về: (dấu * là context đang trỏ đến)
CURRENT   NAME                   CLUSTER                AUTHINFO               NAMESPACE
          docker-desktop         docker-desktop         docker-desktop
          hoanglinhdigital.com   hoanglinhdigital.com   hoanglinhdigital.com
*         minikube               minikube               minikube               default

#Chuyển context về minikube:
kubectl config use-context <context-name>
#Ví dụ:
kubectl config use-context minikube


#Troubleshoot lỗi câu lệnh:
minikube ip ->Kết quả trả về lỗi

#Chạy lệnh sau:
docker info
docker context ls
docker context use default

#Trên windows, Restart docker nếu chưa hết
#Trên linux: systemctl restart docker
#Trên mac: restart docker desktop
