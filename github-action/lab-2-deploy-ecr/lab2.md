## Lab 2: Tạo một Github Action có nhiệm vụ triển khai ECS Cluster
*Yêu cầu đã hoàn thành bài lab-1

### Step1: Chuẩn bị một ECS Cluster.

Các bạn sử dụng code trong thư mục `terraform` để deploy resource.  
Chi tiết xem file `terraform/command.sh`
Kiểm tra resource được tạo ra trên AWS thành công, có thể truy cập ALB bình thường.

### Step 2: Tạo Github Workflow
Copy file `deploy-ecs.yml` vào thư mục `.github/workflows` 
Chỉnh sửa các vị trí sau:
```
AWS_REGION: ap-southeast-1
ECR_REGISTRY: 799227077423.dkr.ecr.ap-southeast-1.amazonaws.com
ECR_REPOSITORY: nodejs-random-color-0529
TASK_FAMILY: nodejs-task-definition
SERVICE_NAME: nodejs-service
```
### Step 4: Commit & Push lên Github
Modify trang Index với nội dung phù hợp
```
git add .
git commit -m "Add Deploy ECS Workflow"
git tag -a v1.0.1 -m "Test v1.0.1 by Github Action"
git push origin master
git push --tags
```
Kiểm tra workflow mới được tạo ra trên Github.

### Step 5: Kiểm tra
- Truy cập vào Github, mở repository, tab Action và theo dõi Action mới được tạo ra.  
- Thực hiện chạy action, nhập các thông tin tham số cần thiết: Tag, Cluster name.
*Lưu ý: Deploy lên cluster đang không nhận traffic (xem resource map của ALB để biết).  
- Kiểm tra Code mới được triển khai.
- Truy cập ALB port 81 để kiểm tra code mới được triển khai.
