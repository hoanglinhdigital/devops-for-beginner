#Đề bài
# Yêu cầu: Sử dụng Terraform để tạo ra các resource cơ bản gồm VPC, Subnet, Security Group, ALB, Target Group x2, ECS Cluster x2.
# Tạo một các jobs Jenkins sau:
# Job Build: nhận tham số là version tag, build source code và push Docker Image lên ECR với tag là <version>.
# Job Deploy: nhận tham số là version, ECS Cluster name. Có nhiệm vụ triển khai lên ECS Cluster.
# Job Switch traffic: có nhiệm vụ switch traffic (trên ALB) giữa 2 Target Group blue/green.
# Job Clear resource: nhận tham số là Cluster name, có nhiệm vụ Stop hết task trên Cluster (hoặc chỉnh service capacity về 0).

#=========Step 1: Tạo ECR Repository
# Tạo một ECR repository: nodejs-random-color
# *Tham khảo lab số 5 của chương CICD Jenkins.

#=========Step2: Tạo Job Build:
#Fork repository sau về acount của bạn (Bỏ qua nếu vẫn còn repository của chương CICD Jenkins):
https://github.com/hoanglinhdigital/nodejs-random-color

#Tạo một Job Jenkins mới, đặt tên là BlueGreen-Job1-Build.
#Nhập tham số cho job: VERSION (String), default value: latest
#Sử dụng code Pipeline trong file: blue-green_job1-build-docker.groovy
#  -Sửa dòng 12: Link URL đến repo github của bạn (sau khi fork).
#  -Sửa dòng 24,25,26: Thay đổi thông tin của ECR repository của bạn.
#Save job lại.

#Chỉnh sửa code html của trang index, thêm đoạn text "v1.0.0" -> Commit và push code lên github.

#Tạo một tag và push lên github repository của bạn. Vd: v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
#Chạy job [BlueGreen-Job1-Build] với tham số version = v1.0.0
#Kiểm tra job chạy thành công và image đã được push lên ECR repository.

#=========Step 3: Sử dụng Terraform để deploy ra stack
cd terraform/singapore-dev
#Chỉnh sửa file sau: singapore-dev/terraform.tfvars
#  - Dòng 6: ecr_repo_url ->chỉnh sửa thành url ECR repository của bạn ví dụ:
     430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:v1.0.0
#Chạy các lệnh sau:
terraform init
terraform plan --var-file "terraform.tfvars"
terraform apply --var-file "terraform.tfvars"

#Kiểm tra resource được tạo ra thành công trên AWS.
#Lưu ý, terraform stack sẽ tạo ra 2 cụm ECS Cluster và 2 Target Group, 1 ALB. Trên ALB có 2 listener nên cần kiểm tra cả hai.
#Truy cập ALB bằng port 80, kiểm tra trang index hiển thị đúng version v1.0.0 (2 màu khác nhau).
#Truy cập ALB bằng port 81, kiểm tra trang index hiển thị đúng version v1.0.0 (2 màu khác nhau).

#==========Step 4: Tạo Job Deploy:
#Tạo một Job Jenkins mới, đặt tên là BlueGreen-Job2-Deploy-ECS.
#Nhập tham số cho job: VERSION (String), default value: latest
#Nhập tham số cho job: CLUSTER_NAME (Choice), Cho chọn 2 giá trị là: udemy-devops-cluster-blue, udemy-devops-cluster-green
#Sử dụng code Pipeline trong file: blue-green_job2-deploy-ecs.groovy
#  - dòng 4: Sửa ECR repository url của bạn.
#Save job lại.

#Chạy thử và kiểm tra job deploy.
#Chỉnh sửa code html của trang index, thêm đoạn text "v1.0.1".
git add .
git commit -m "Update version 1.0.1"
git push origin master
#Tạo một tag và push lên github repository của bạn. Vd: v1.0.1
git tag -a v1.0.1 -m "Release v1.0.1"
git push origin v1.0.1
#Chạy job [BlueGreen-Job1-Build] với tham số version = v1.0.1
#Kiểm tra job chạy thành công và image đã được push lên ECR repository.

#Chạy job [BlueGreen-Job2-Deploy-ECS] với tham số version = v1.0.1, cluster_name = udemy-devops-cluster-green
#Truy cập ALB và kiểm tra trang index hiển thị đúng version trên cả 2 listener của ALB.
#<ALB DNS>:/80 =>kết quả ra version 1.0.0
#<ALB DNS>:/81 =>kết quả ra version 1.0.1


#==========Step 5: Tạo Job Switch traffic:
#Add Policy cho IAM Role của Jenkins để có quyền switch traffic giữa 2 Target Group.
#Policy name: ElasticLoadBalancingFullAccess

#Tạo một Job Jenkins mới, đặt tên là BlueGreen-Job3-Switch-Traffic.
#Sử dụng code Pipeline trong file: blue-green_job3-switch-traffic.groovy
#  - Dòng 4 sửa thông tin ALB_ARN thành ARN của ALB của bạn.
#Save job lại.

#Chạy job [BlueGreen-Job3-Switch-Traffic] và kiểm tra trang index hiển thị đúng version trên cả 2 listener của ALB.
#<ALB DNS>:/80 =>kết quả ra version 1.0.1
#<ALB DNS>:/81 =>kết quả ra version 1.0.0


#==========Step 6: Tạo Job Clear resource:
#Tạo một Job Jenkins mới, đặt tên là BlueGreen-Job4-Clear-Resource.
#Nhập tham số cho job: CLUSTER_NAME (Choice), Cho chọn 2 giá trị là: udemy-devops-cluster-blue, udemy-devops-cluster-green
#Sử dụng code Pipeline trong file: blue-green_job4-clear-resource.groovy
#Save job lại.

#kiểm tra xem code trên cluster blue hay green đang cũ hơn?
#Chạy job [BlueGreen-Job4-Clear-Resource] với tham số cluster_name = <cluster name xác nhận ở bước trên>
#Kiểm tra trên AWS console xem task đã bị stop hết chưa?

#==========Step 8: Clear resource
#Sau khi hoàn thành, xóa toàn bộ resource đã tạo ra bằng terraform.
terraform destroy --var-file "terraform.tfvars"



