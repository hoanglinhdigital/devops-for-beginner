# Yêu cầu: 
# Tạo một Persistent volume & một persistent volume claim
# Gán volume claim vào trong một NodePort service chạy MySQL (single pod).
# Triển khai resource. Kết nối tới MySQL và insert một vài data.
# Thử delete pod.
# Kiểm tra Pod được khôi phục.
# Truy cập lại MySQL kiểm tra xem data còn tồn tại?

kubectl create -f persistent-volume.yaml

kubectl get all
kubectl get pv
kubectl get pvc
kubectl get pvc --all-namespaces

#Mở một tab terminal mới, chạy lệnh sau để tạo tunnel tới service mysql-service
minikube service mysql-service --url

#kết nôi tới MySQL sử dụng url trên và insert một vài data
#  - host: localhost
#  - port: <port lấy ra từ lệnh minikube service ở trên>
#  - username: root
#  - password: password trong file cấu hình.

#Script mẫu
-- Create database
CREATE DATABASE mydb;

-- Use the database
USE mydb;
-- Create table
CREATE TABLE employee (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT,
  salary DECIMAL(10,2)
);
-- Insert sample data
INSERT INTO employee (name, age, salary) VALUES
  ('John Doe', 30, 5000),
  ('Jane Smith', 25, 4000),
  ('Mike Johnson', 35, 6000);

select * from employee;

#delete pod
kubectl get pods -o wide
kubectl delete pod mysql-deployment-<xxxxxx>

#Đợi đến khi pod tự phục hồi.

#Truy cập lại MySQL Workbench và kiểm tra xem data còn tồn tại không.

#Terminate resources
kubectl delete -f persistent-volume.yaml


