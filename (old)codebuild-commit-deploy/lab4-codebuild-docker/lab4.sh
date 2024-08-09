# Yêu cầu:
# Tạo một Job trong CodeBuild có nhiệm vụ checkout một Nodejs project (từ CodeCommit).
# Build
# Push artifact lên S3. 

#===Step1===
#Tạo một repository trên CodeCommit, tên repo: 
codecommit-nodejs-random-color
#Cấu hình SSH key hoặc username/password để push code lên repo.
#Thử checkout code từ CodeCommit.

#===Step2=== Chuẩn bị source code.
#Checkout repo sau (Nodejs + Webpack):
https://github.com/hoanglinhdigital/nodejs-random-color
#Copy vào trong thư mục CodeCommit project, modify nếu cần, push lên CodeCommit repository của bạn.

#===Step3===
#tạo một ECR Repository để chứa docker image. Ví dụ:
nodejs-random-color

#===Step4=== Chuẩn bị một account DockerHub.
#Tạo 2 secret manager để lưu username/password của DockerHub. Type: Plaintext
dockerhub-username-secret
dockerhub-password-secret

#===Step5=== Tạo một Job trong CodeBuild
#Tên job: 
udemy-devops-nodejs-docker-build

#Chọn Source: CodeCommit, chọn repo: 
codecommit-nodejs-random-color
#Branch: chọn "master"

#Chọn Environment: 
#  - Managed image, OS: Ubuntu
#  - Runtime: Standard
#  - Image: aws/codebuild/standard:5.0
#  - Image Version: Always use latest image...

#Chọn Service role: Create a service role in your account (*Hoặc sử dụng lại role của bài lab 2).

#Buildspec
#Chọn Insert Build Command
#Code: tham khảo file buildspec.yml trong thư mục cùng cấp với file này.
#Tham khảo: danh sách runtime được codebuild hỗ trợ: https://docs.aws.amazon.com/codebuild/latest/userguide/runtime-versions.html
#  - Dòng 13: Thay lệnh login bằng lệnh lấy từ ECR.
#  - Dòng 14 chỗ REPOSITORY_URI -> thay thế ECR repository của bạn vào.

#Chọn Artifacts: chọn No Artifacts *Lý do: Sẽ sử dụng command để push image trực tiếp lên ECR.


#Click vào: Additional configuration
#Chỗ: Privileged, tick vào "Enable this flag if you want to build Docker images or want your builds to get elevated privileges"

#Chọn CloudWatch logs: Create a new log group
#Save job lại.

#===Step6===
#Add policy vào role của CodeBuild service role, để cho phép CodeBuild push image lên ECR và đọc secret manager.
AmazonEC2ContainerRegistryFullAccess
SecretsManagerReadWrite

#===Step7=== Chạy job và kiểm tra kết quả. 
#Expect: Image được push lên ECR thành công.

#================================================================================================
#Troubleshooting lỗi permission nếu có.
#Nếu bị một trong các lỗi không access được: Cloudwatch Log, ECR, S3, SecretManager, các bạn thêm các policy sau vào role của CodeBuild service role.
AmazonS3FullAccess
AWSCodeCommitFullAccess
CloudWatchFullAccessV2
CloudWatchLogsFullAccess
ElasticContainerRegistryFullAccess
SecretsManagerReadWrite

#Troubleshooting lỗi: toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit
#Cách fix: thêm lệnh login vào DockerHub vào trước lệnh build image.
