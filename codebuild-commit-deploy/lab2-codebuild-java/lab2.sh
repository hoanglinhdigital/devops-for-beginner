# Yêu cầu:
# Tạo một Job trong CodeBuild có nhiệm vụ checkout một Java project (từ CodeCommit).
# Build
# Push artifact lên S3. 

#Step1: Tạo một repository trên CodeCommit
#Tên repo: 
codecommit-java-project
#Cấu hình SSH key hoặc username/password để push code lên repo.
#Thử checkout code từ CodeCommit.

#Step2: Chuẩn bị source code.
#Checkout repo sau: 
https://github.com/hoanglinhdigital/java-elasticbeanstalk-sample
#Copy vào trong thư mục CodeCommit project, modify nếu cần, push lên CodeCommit repository của bạn.

#Step3: tạo một S3 bucket để chứa artifact. Ví dụ:
udemy-devops-codebuild-linh

#Step4: Tạo một Job trong CodeBuild
#Tên job: 
udemy-devops-java-project-build

#Chọn Source: CodeCommit, chọn repo: 
codecommit-java-project
#Chọn Environment: 
#  - Managed image, OS: Ubuntu, 
#  - Runtime: Standard
#  - Image: aws/codebuild/standard:7.0
#  - Image Version: Always use latest image for runtime version

#Chọn Service role: Create a service role in your account

#Buildspec
#Chọn Insert Build Command
#Code: tham khảo file buildspec.yml trong thư mục cùng cấp với file này.
#Tham khảo: danh sách runtime được codebuild hỗ trợ: https://docs.aws.amazon.com/codebuild/latest/userguide/runtime-versions.html

#Artifacts 
#Chọn Type: Amazon S3, 
#  - Bucket name: <Tên bucket đã được các bạn tạo ra trước đó>
#  - Name: demo_java_artifact
#  - Path: <để trống>
#  - Namespace type: None
#  - Artifacts packaging: None

#Aditional configuration: để mặc định.
#Chọn CloudWatch logs: Create a new log group
#Save job lại.

#Step5: Chạy job và kiểm tra kết quả. 

#====Troubleshooting lỗi permission nếu có.
#Nếu bị lỗi không tạo được cloudwatch Log, không pull được code hoặc acces S3, các bạn thêm các policy sau vào role của CodeBuild service role.
AmazonS3FullAccess
AWSCodeCommitFullAccess
CloudWatchFullAccessV2
CloudWatchLogsFullAccess