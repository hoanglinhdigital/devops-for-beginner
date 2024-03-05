kubectl apply -f configmap-simple.yaml

#Lấy ra các giá trị của configmap
kubectl get configmap my-configmap -o yaml

kubectl get pods
kubectl get pods mysql-deployment-65c44d99fb-hglw4 -o yaml

#Tạo tunnel.
minikube service mysql-service --url

#Bạn có thể thử kết nối với MySQL thông qua password trong ConfigMap

#Xoá resource.
kubectl delete -f configmap-simple.yaml

