# ===Yêu cầu===
# Tạo một Job trong CodeBuild có nhiệm vụ checkout một Java project (từ Github).
# Build
# Push artifact lên S3. 

#Step1: Đăng nhập thành công vào Github, cấu hình SSH key để checkout source code nếu cần.
#*Tham khảo lại chương Thao tác cơ bản với Git.

#Step2: Fork repository sau với một tên mới 
https://github.com/hoanglinhdigital/java-elasticbeanstalk-sample
#Tên repo vd: 
java-elasticbeanstalk-sample-yyyymmdd

#Step3: tạo một S3 bucket để chứa artifact. Ví dụ:
udemy-devops-codebuild-linh

#Step4: Tạo một Build Project trong CodeBuild
#Tên job: 
udemy-devops-java-project-build

#Chọn Source: Github, nhấn nút Connect to Github, sẽ mở ra một popup yêu cầu login vào Github và cấp quyền cho CodeBuild.
#Sau khi login thành công, quay trở lại màn hình CodeBuild, chọn repository:
java-elasticbeanstalk-sample-yyyymmdd
#Branch chọn "master"

#Chọn Environment: 
  - Managed image, OS: Ubuntu, 
  - Runtime: Standard
  - Image: aws/codebuild/standard:7.0
  - Image Version: Always use latest image for runtime version

#Chọn Service role: Create a service role in your account
udemy-devops-codebuild-role

#Buildspec
#Chọn Insert Build Command
#Code: tham khảo file "buildspec.yml" trong thư mục cùng cấp với file này.
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

#Step5: Chạy CodeBuild job và kiểm tra kết quả. 

#====Troubleshooting lỗi permission nếu có.
#Nếu bị lỗi không tạo được cloudwatch Log, không pull được code hoặc acces S3, các bạn thêm các policy sau vào role của CodeBuild service role.
AmazonS3FullAccess
CloudWatchFullAccessV2
CloudWatchLogsFullAccess