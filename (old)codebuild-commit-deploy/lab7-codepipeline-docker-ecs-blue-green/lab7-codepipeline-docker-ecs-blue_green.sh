# Yêu cầu:​
# Modify ECS Service (terraform) chuyển deploymetn controller thành CODE_DEPLOY.​
# Thêm 1 target group và 1 listener trên ALB (port 81).​
# Tạo một Pipeline trong đó step CodeDeploy sử dụng chiến lược Blue-Green​
# Update code, push lên CodeCommit.​
# Theo dõi pipeline​
# Chờ đến step switch traffic.
https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-ecs-ecr-codedeploy.html

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

#===Step3=== Tạo một CodeDeploy Appliation & Deployment Group.
#Truy cập vào CodeDeploy -> Application -> Create application
# Đặt tên, ví dụ:
udemy-devops-deploy-ecs-bluegreen-app
#Chọn Create application.

#Chọn Application vừa tạo, chọn tab "Deployment Groups" -> Create deployment group.
# Đặt tên cho group, ví dụ:
udemy-devops-ecs-nodejs-deployment-group
#Service role: Chọn role cho code deploy.
#Environment configuration
- Chọn Cluster name: udemy-devops-ecs-cluster
- Chọn service name: nodejs-service
- Chọn Load Balancer: udemy-devops-alb
- Production listener port: 80
- Test listener port: 81
- Target Group 1 name: chọn Blue
- Target Group 2 green: chọn Green
#Deployment settings
- Traffic rerouting chọn: Specify when to reroute traffic
- chọn 5 phút.
- Deployment configuration: chọn CodeDeployDefault.ECSAllAtOnce

#Nhấn "Create deployment group".

##CHÚ Ý: Add các role sau vào CodeDeploy role (nếu chưa có).
- AmazonEC2ContainerRegistryFullAccess
- AmazonECS_FullAccess
- AmazonS3FullAccess
- AWSCodeDeployRole
- ElasticLoadBalancingFullAccess

#===Step4: Deploy thử bằng CodeDeploy (Lưu ý bước này vẫn chưa có sự tham gia của CodePipline & trigger tự động.)
#Modify code, push lên CodeCommit.
#Chạy lại job của CodeBuild, kiểm tra ECR được tạo ra.

#Truy cập vào Task Definition, tạo ra 1 revision mới với ECR image vừa build xong.

#Truy cập vào ECS Cluster -> Service nodejs, chọn Update service.
#Chọn revision mới (TaskDefinition vừa tạo ra)
#Chọn deployment provider (powered by CodeDeploy).
#Chọn Update.

#Theo dõi quá trình deploy trong CodeDeploy, chờ tới bước waiting.
#Truy cập ALB thông qua port 81 để kiểm tra version mới có OK không?
#Nhấn nút: "Reroute traffic"

#Truy cập ALB thông qua port 88 để kiểm tra version đã được switch sang OK.
#Nhấn nút: Terminate original task set (xoá bỏ resource version cũ.)

#============KẾT HỢP TẤT CẢ TRONG MỘT PIPELINE================
#===Step 1: Modify CodeBuild project
#Tham khảo file: buildspec.yml trong thư mục lab7.
# Mục đích của cập nhật này:
- Thêm file appspec.yml vào artiract output để CodeDeploy có thể deploy tự động trong luồng CICD của CodePipeline.
    - imagedefinitions.json: tạo ra trong quá trình build.
    - imageDetail.json: tạo ra trong quá trình build.
    - appspec.yaml: copy nguyên từ CodeCommit repo trong quá trình build.
    - taskdef.json: copy nguyên từ CodeCommit repo trong quá trình build.
    
#Read: https://docs.aws.amazon.com/codepipeline/latest/userguide/file-reference.html#file-reference-ecs-bluegreen

#===Step2: Tạo một Pipeline trong CodePipeline.
udemy-devops-deploy-ecs-pipeline-blue-green
#Version chọn V2
#Service role: Chọn tạo role mới hoặc lấy lại role cũ.

#Add source stage
#Chọn CodeCommit và chọn repo: 
codecommit-nodejs-random-color
#Branch name: master

#Add build stage
#Build chọn CodeBuild, chọn build project tương ứng.

#Add deploy stage
#Deploy provider chọn: Amazon ECS (Blue/Green)
#AWS CodeDeploy application name: chọn application đã tạo ở trên.
#AWS CodeDeploy deployment group: chọn deployment group đã tạo ở trên.
#Amazon ECS task definition: chọn BuildArtifact và nhập "taskdef.json"
#AWS CodeDeploy AppSpec file: chọn BuildArtifact và nhập "appspec.yaml"
#Dynamically update task definition image - optional: chọn BuildArtifact và nhập: "IMAGE_NAME"

#Review và nhấn: Create pipeline.
#Ngay sau khi pipeline được tạo ra, nhấn stop pipeline để dừng pipeline.

#===Step3: Modify source code và push lên CodeCommit
#Theo dõi pipeline.
#Theo dõi trạng thái của ECS Cluster - Nodejs Service.
#Theo dõi trạng thái deploy của CodeDeploy
#Chờ tới bước Waiting, truy cập ALB thông qua port 81 xem OK không?
#Nếu OK: nhấn nút: "Reroute traffic"
#Truy cập ALB thông qua port 80 xem version mới đã được switch chưa?
#Nếu OK: nhấn nút: "Terminate original task set"
#Vào trong ECS -> Service -> Kiểm tra version cũ được terminate.

#===Troubleshooting===
#Nếu gặp lỗi khi chạy job deploy, kiểm tra lại các bước trên, xem log của job deploy.
#Permission: Kiểm tra lại IAM role của CodeBuild, CodeDeploy, CodePipeline, ...