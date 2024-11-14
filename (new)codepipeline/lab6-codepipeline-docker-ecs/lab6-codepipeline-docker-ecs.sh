# Yêu cầu:​
# *Sử dụng lại output của bài lab 4 (docker image trên ECR repository)   ​
# Triển khai một cluster ECS sử dụng Terraform cho sẵn.​
# Tạo một Job trong Code Deploy có nhiệm vụ deploy ECR image lên ECS Cluster.​
# Modify Code, đánh tag mới.​
# Chạy lại job build, kiểm tra new Docker image.​
# Chạy job deploy với version mới.​
# Kiểm tra và truy cập thông qua ALB => new version.​
#===================================================================================================
#Tham khảo ECS Deployment Controller: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeploymentController.html

#===Lưu ý: Tái sử dụng lại job Build từ lab 4, sử dụng lại image đã build từ lab 4.

#===Step1=== Sử dụng Terraform để triển khai một stack có VPC, ECS, ALB, ... trên region Singapore.
#cd vào thư mục terraform/singapore-dev
#Edit file terraform.tfvars:
#  - Dòng số 6: sửa "ecr_repo_url" thành url của ECR repository của bạn *Lưu ý điền chính xác tag của image.
#Tham khảo file command.sh để apply terraform.
#Kiểm tra resource được tạo ra, truy cập ALB -> website lên là OK.

#===Step2=== Modify job CodeBuild ở bài lab Docker.
#Tham khảo file buildspect.yml trong cùng thu mục với file này.
#Mục đích thay đổi là tạo ra file imagedefinitions.json để sử dụng cho CodeDeploy.

#===Step3=== Tạo một Deploy Application trong CodeDeploy có nhiệm vụ deploy theo phương pháp rollout lên ECS Cluster.
cmc-devops-deploy-ecs-pipeline-rollout
#Chọn tạo ra new ServiceRole, Rolename: 
AWSCodePipeline-deploy-ecs-pipeline-rollout-role


#===Step4=== Modify code, push lên Github.

#===Step5=== Chạy Pipeline với version mới.

#===Step6=== Kiểm tra và truy cập thông qua ALB => new version.

#===Troubleshooting===
#Nếu gặp lỗi khi chạy job deploy, kiểm tra lại các bước trên, xem log của job deploy.
#Permission: Kiểm tra lại IAM role của CodeBuild, CodeDeploy, CodePipeline, ...