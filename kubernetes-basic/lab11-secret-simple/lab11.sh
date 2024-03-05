#Sử dụng câu lệnh sau để tạo base 64 của một chuỗi:
echo -n "your text here" | base64
#Ví dụ:
echo -n "root" | base64
echo -n "VeryStrongPassword123" | base64

#Copy giá trị của base64 và thay thế vào file secret-simple.yaml

#Apply 
kubectl apply -f secret-simple.yaml

#Lấy ra các giá trị của secret
kubectl get secret my-secret -o yaml
kubectl get secret my-secret -o jsonpath="{.data.MYSQL_ROOT_USER}" | base64 --decode
kubectl get secret my-secret -o jsonpath="{.data.MYSQL_ROOT_PASSWORD}" | base64 --decode
kubectl get secret my-secret -o jsonpath="{.data.ADDRESS}" | base64 --decode

#Tạo tunnel.
minikube service mysql-service --url

#Bạn có thể thử kết nối với MySQL thông qua password trong Secret

#Xoá resource.
kubectl delete -f secret-simple.yaml