# Yêu cầu:​
# Modify ECS Service (terraform) chuyển deploymetn controller thành CODE_DEPLOY.​
# Thêm 1 target group và 1 listener trên ALB (port 81).​
# Tạo một Pipeline trong đó step CodeDeploy sử dụng chiến lược Blue-Green​
# Update code, push lên CodeCommit.​
# Theo dõi pipeline​
# Chờ đến step switch traffic.

#===================================================================================================
#Tham khảo ECS Deployment Controller: https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeploymentController.html

#===Lưu ý: Tái sử dụng lại job Build từ lab 4, sử dụng lại image đã build từ lab 4.

#===Step1=== Sử dụng Terraform để triển khai một stack có VPC, ECS, ALB, ... trên region Singapore.
#cd vào thư mục terraform/singapore-dev
#Edit file terraform.tfvars:
#  - Dòng số 6: sửa "ecr_repo_url" thành url của ECR repository của bạn *Lưu ý điền chính xác tag của image.
#Tham khảo file command.sh để apply terraform.
#Trong bài Lab7 này có 1 số thay đổi với terraform so với bài lab6:
#  - Điều chỉnh deployment_controller của service nodejs thành CODE_DEPLOY
#  - Thêm 1 target group mới cho service nodejs
#  - Thêm 1 listener mới trên ALB (port 81), mục đích để có thể test traffic trước khi switch Blue-Green.

#Kiểm tra resource được tạo ra, truy cập ALB -> website lên là OK.

#===Step3=== Tạo một Pipeline trong CodePipeline có nhiệm vụ deploy ECR image lên ECS Cluster.
udemy-devops-deploy-ecs-pipeline-bluegreen
#Chọn tạo ra new ServiceRole, Rolename: 
AWSCodePipeline-deploy-ecs-pipeline-bluegreen-role

#===Step4=== Modify code, push lên CodeCommit.

#===Step5=== Chạy Pipeline với version mới.

#===Step6=== Kiểm tra và truy cập thông qua ALB => new version.

#===Troubleshooting===
#Nếu gặp lỗi khi chạy job deploy, kiểm tra lại các bước trên, xem log của job deploy.
#Permission: Kiểm tra lại IAM role của CodeBuild, CodeDeploy, CodePipeline, ...