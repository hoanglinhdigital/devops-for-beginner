## Lab 1: Tạo một Github Action có nhiệm vụ build docker image & push lên ECR

### Step1: Chuẩn bị một repository  
Các bạn có thể fork repository này để sử dụng:  
https://github.com/hoanglinhdigital/nodejs-random-color

### Step 2: Tạo một ECR repository
Truy cập vào AWS ECR và tạo một repository vd: `nodejs-random-color`

### Step 3: Tạo IAM user có quyền cần thiết
Tạo một IAM user có quyền cần thiết vd PowerUserAccess  
Tạo một Access Key và tải về.

Cấu hình access key trong Github Secret của repository.
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

### Step 4: Tạo thư mục .github/workflows
Tạo thư mục `.github/workflows` tại root level của project

### Step 5: Tạo file cấu hình Github Action  
Copy nội dung file `build-docker-v1.yml` vào trong `.github/workflows/build-docker.yml`
Chỉnh sửa các vị trí sau:
```
AWS_REGION: ap-southeast-1
ECR_REGISTRY: 799227077423.dkr.ecr.ap-southeast-1.amazonaws.com
ECR_REPOSITORY: nodejs-random-color-0529

```
### Step 6: Commit & Push lên Github
Modify trang `public/index.html` với nội dung bất kỳ.
Commit và push lên Github  
```
git add .
git commit -m "modify Index.html, test CICD"
git push origin master
```
Kiểm tra Code được push lên Github.

### Step 7: Kiểm tra
Truy cập vào Github, mở repository, tab Action và theo dõi Action mới được tạo ra.  
Kiểm tra Action được tự động kích hoạt.
Kiểm tra Docker Image được push lên ECR repository với tag `latest`


### Step 8: Modify workflow thành trigger manuall kết hợp với checkout sử dụng tag
Copy nội dung file `build-docker-v2.yml` vào trong `.github/workflows/build-docker.yml`
Chỉnh sửa các vị trí sau:
```
AWS_REGION: ap-southeast-1
ECR_REGISTRY: 799227077423.dkr.ecr.ap-southeast-1.amazonaws.com
ECR_REPOSITORY: nodejs-random-color-0529
```

Modify trang `public/index.html` với nội dung bất kỳ.
Commit và push lên Github  
```
git add .
git commit -m "modify Index.html, test CICD"
git tag -a v1.0.0 -m "Test v1.0.0 by Github Action"
git push origin master
git push --tags
```
Kiểm tra Code được push lên Github.
Chạy Github action với tag `v1.0.0`
Kiểm tra Docker Image được push lên ECR repository với tag `v1.0.0`