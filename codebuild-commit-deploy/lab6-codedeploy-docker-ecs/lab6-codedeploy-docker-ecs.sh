# Yêu cầu:​
# *Sử dụng lại output của bài lab 4 (docker image trên ECR repository)   ​
# Triển khai một cluster ECS sử dụng Terraform cho sẵn.​
# Tạo một Job trong Code Deploy có nhiệm vụ deploy ECR image lên ECS Cluster.​
# Modify Code, đánh tag mới.​
# Chạy lại job build, kiểm tra new Docker image.​
# Chạy job deploy với version mới.​
# Kiểm tra và truy cập thông qua ALB => new version.​
#===================================================================================================

#===Lưu ý: Tái sử dụng lại job Build từ lab 4, sử dụng lại image đã build từ lab 4.

#===Step1=== Sử dụng Terraform để triển khai một stack có VPC, ECS, ALB, ... trên region Singapore.
#cd vào thư mục terraform/singapore-dev
#Edit file terraform.tfvars:
#  - Dòng số 6: sửa "ecr_repo_url" thành url của ECR repository của bạn *Lưu ý điền chính xác tag của image.
#Tham khảo file command.sh để apply terraform.
#Kiểm tra resource được tạo ra, truy cập ALB -> website lên là OK.

#===Step2=== Tạo một Job trong Code Deploy có nhiệm vụ deploy ECR image lên ECS Cluster.
#Tạo một Application trong CodeDeploy, tạo một Deployment Group.

#===Step3=== Modify Code, đánh tag mới. Push lên CodeCommit.

#===Step4=== Chạy lại job build, kiểm tra new Docker image mới được tạo ra.

#===Step5=== Chạy job deploy với version mới.

#===Step6=== Kiểm tra và truy cập thông qua ALB => new version.
