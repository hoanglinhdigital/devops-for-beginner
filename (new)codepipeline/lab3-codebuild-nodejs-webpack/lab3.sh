# Yêu cầu:
# Tạo một Job trong CodeBuild có nhiệm vụ checkout một Nodejs project (từ Github).
# Build
# Push artifact lên S3. 

#Step1: Đăng nhập thành công vào Github, cấu hình SSH key để checkout source code nếu cần.
#*Tham khảo lại chương Thao tác cơ bản với Git.

#Step2: Fork repository sau với một tên mới 
https://github.com/hoanglinhdigital/simple-vue-webpack
#Tên repo vd: 
simple-vue-webpack-yyyymmdd

#Step3: tạo một S3 bucket để chứa artifact (bỏ qua nếu đã tạo trong bài lab trước). Ví dụ:
udemy-devops-codebuild-linh

#Step4: Tạo một Job trong CodeBuild
#Tên job: 
udemy-devops-nodejs-project-build

#Chọn repository (các bạn đã làm bài lab2 không cần login lại với Github)
#Chọn Source: Github, nhấn nút Connect to Github, sẽ mở ra một popup yêu cầu login vào Github và cấp quyền cho CodeBuild.
#Sau khi login thành công, quay trở lại màn hình CodeBuild, chọn repository:

simple-vue-webpack
#Branch: chọn "master"

#Chọn Environment: 
#  - Managed image, OS: Amazon Linux
#  - Runtime: Standard
#  - Image: aws/codebuild/amazonlinux2-x86_64-standard:5.0
#  - Image Version: Always use latest image...

#Chọn Service role: Create a service role in your account (Hoặc chọn lại role ở bài lab2)

#Buildspec
#Chọn Insert Build Command
#Code: tham khảo file "buildspec.yml" trong thư mục cùng cấp với file này.
#  - Dòng số 20: thay thế s3 bucket bằng tên s3 bucket của bạn.

#Tham khảo: danh sách runtime được codebuild hỗ trợ: https://docs.aws.amazon.com/codebuild/latest/userguide/runtime-versions.html

#Chọn Artifacts: chọn No Artifacts *Lý do: Sẽ sử dụng AWS CLI để upload trực tiếp lên S3.

#Aditional configuration: để mặc định.
#Chọn CloudWatch logs: Create a new log group
#Save job lại.

#Step5: Chạy job và kiểm tra kết quả. 

#Troubleshooting lỗi permission nếu có.
#Nếu bị lỗi không tạo được cloudwatch Log, không pull được code hoặc acces S3, các bạn thêm các policy sau vào role của CodeBuild service role.
AmazonS3FullAccess
CloudWatchFullAccessV2
CloudWatchLogsFullAccess