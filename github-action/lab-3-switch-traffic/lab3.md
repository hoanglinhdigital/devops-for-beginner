## Lab 3: Tạo một Github Action có nhiệm vụ Switch traffic trên ALB
*Yêu cầu đã hoàn thành bài lab-1, lab-2

### Step 1: Tạo Github Workflow
Copy file `switch-traffic.yml` vào thư mục `.github/workflows` 
Chỉnh sửa các vị trí sau:
```
AWS_REGION: ap-southeast-1
ALB_ARN: arn:aws:elasticloadbalancing:ap-southeast-1:799227077423:loadbalancer/app/udemy-devops-alb/4d92fdb74f141347
```
### Step 2: Commit & Push lên Github
```
git add .
git commit -m "Add Switch Traffic Workflow"
git push origin master
```
Kiểm tra workflow mới được tạo ra trên Github.

### Step 3: Kiểm tra
- Truy cập vào Github, mở repository, tab Action và theo dõi Action mới được tạo ra.  
- Thực hiện chạy action Switch traffic.
- Kiểm tra Traffic được switch (vào ALB -> Resource map)
- Truy cập ALB thông qua port 80 để kiểm tra version mới đã được switch.

