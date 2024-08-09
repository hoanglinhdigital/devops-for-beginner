# Yêu cầu:
# Tạo một Job trong CodeBuild có nhiệm vụ checkout một Nodejs project (từ CodeCommit).
# Build
# Push artifact lên S3. 

#Step1: Tạo một repository trên CodeCommit
#Tên repo: 
codecommit-nodejs-webpack
#Cấu hình SSH key hoặc username/password để push code lên repo.
#Thử checkout code từ CodeCommit.

#Step2: Chuẩn bị source code.
#Checkout repo sau (Nodejs + Webpack):
https://github.com/hoanglinhdigital/simple-vue-webpack.git
#Copy vào trong thư mục CodeCommit project, modify nếu cần, push lên CodeCommit repository của bạn.

#Step3: tạo một S3 bucket để chứa artifact. Ví dụ:
udemy-devops-codebuild-linh

#Step4: Tạo một Job trong CodeBuild
#Tên job: 
udemy-devops-nodejs-project-build

#Chọn Source: CodeCommit, chọn repo: 
codecommit-nodejs-webpack
#Branch: chọn "main"

#Chọn Environment: 
#  - Managed image, OS: Amazon Linux
#  - Runtime: Standard
#  - Image: aws/codebuild/amazonlinux2-x86_64-standard:5.0
#  - Image Version: Always use latest image...

#Chọn Service role: Create a service role in your account (Hoặc chọn lại role ở bài lab2)

#Buildspec
#Chọn Insert Build Command
#Code: tham khảo file buildspec.yml trong thư mục cùng cấp với file này.
#  - Dòng 20: thay thế tên bucket của bạn.

#Tham khảo: danh sách runtime được codebuild hỗ trợ: https://docs.aws.amazon.com/codebuild/latest/userguide/runtime-versions.html

#Chọn Artifacts: chọn No Artifacts *Lý do: Sẽ sử dụng command để upload trực tiếp lên S3.

#Aditional configuration: để mặc định.
#Chọn CloudWatch logs: Create a new log group
#Save job lại.

#Step5: Chạy job và kiểm tra kết quả. 

#Troubleshooting lỗi permission nếu có.
#Nếu bị lỗi không tạo được cloudwatch Log, không pull được code hoặc acces S3, các bạn thêm các policy sau vào role của CodeBuild service role.
AmazonS3FullAccess
AWSCodeCommitFullAccess
CloudWatchFullAccessV2
CloudWatchLogsFullAccess