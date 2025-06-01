## Lab 5: Kết hợp tất cả trong 1 workflow duy nhất
*Yêu cầu đã hoàn thành bài lab-1, lab-2, lab-3, lab-4

### Step 1: Tạo Github Workflow
Copy file `blue-green-deployment.yml` vào thư mục `.github/workflows` 
Chỉnh sửa các vị trí sau:
```
BLUE_CLUSTER: udemy-devops-cluster-blue
GREEN_CLUSTER: udemy-devops-cluster-green
```
### Step 2: Commit & Push lên Github
Modify trang index với nội dung phù hợp vd `Version 1.0.2 test full workflow with GithubAction`  
Commit & push lên Github
```
git add .
git commit -m "Add Blue-Green full workflow"
git tag -a v1.0.2 -m "Test v1.0.2 by Github Action"
git push origin master
git push --tags
```
Kiểm tra workflow mới được tạo ra trên Github.

### Step 3: Kiểm tra
- Truy cập vào Github, mở repository, tab Action và theo dõi Action mới được tạo ra.  
- Thực hiện chạy action `Complete Blue-Green Deployment`, nhập các thông tin tham số cần thiết: Tag của version cần deploy, Cluster sẽ deploy, Switch traffic ngay sau khi deploy, clear resource cũ ngay sau khi deploy.  
*Lưu ý: Chọn Cluster đang không nhận traffic (xem resource map của ALB để biết).  
- Kiểm tra quá trình triển khai, switch traffic và clear resource cũ.

