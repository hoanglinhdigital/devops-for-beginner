## Lab 4: Tạo một Github Action có nhiệm vụ clear old ECS Cluster
*Yêu cầu đã hoàn thành bài lab-1, lab-2, lab-3

### Step 1: Tạo Github Workflow
Copy file `clear-resources.yml` vào thư mục `.github/workflows` 
Chỉnh sửa các vị trí sau:
```
AWS_REGION: ap-southeast-1
SERVICE_NAME: nodejs-service
```
### Step 2: Commit & Push lên Github
```
git add .
git commit -m "Add clear old ECS workflow"
git push origin master
```
Kiểm tra workflow mới được tạo ra trên Github.

### Step 3: Kiểm tra
- Truy cập vào Github, mở repository, tab Action và theo dõi Action mới được tạo ra.  
- Thực hiện chạy action `Clear ECS Resources`, nhập các thông tin tham số cần thiết: Cluster name.
*Lưu ý: Clear cluster đang không nhận traffic (xem resource map của ALB để biết).  
- Kiểm tra Cluster với code cũ được clear (số lượng task về 0).

