# Yêu cầu:​
# *Sử dụng lại output của bài lab CodeBuild – Java project.​
# Tạo một Elastic Beanstalk Application+environment chạy Java, sử dụng file .jar của bài lab 2. Kiểm tra application chạy thành công.​
# Tạo một Job trong Code Deploy có nhiệm vụ deploy file war lên environment.​
# Modify code, chạy lại job build, kiểm tra artifact.​
# Chạy job CodeDeploy, kiểm tra và truy cập environment đã được cập nhật.​
#==========================================================================​

#Step 1: Set up ElasticBeanstalk environment
#Tạo một ElasticBeanstalk environment cho Java application.
# - Platform: Java
# - Platform branch: corretto17
# - Platform version: 4.2.1 Recommended
#Chi tiết mời các bạn xem video.

#Step 2: Tạo một S3 bucket (bỏ qua nếu đã có sẵn artifact từ bài lab CodeBuild – Java project)

#Step 3: Tạo một CodePipeline có nhiệm vụ tích hợp Github, CodeBuild và ElaticBeanstalk.
#Truy cập vào CodePipeline.
#Chọn Create pipeline.
#Điền thông tin:
# - Pipeline name: java-beanstalk-cicd-pipeline
# - Pipeline type chọn: V2
# - Service role: New service role
# - Execution mode: chọn Superseded
# - Service role chọn "New service role", điền Role name nêu muốn thay đổi.
# - Nhấn Next

#Add source stage
# - Source provider: Github
# - Repository name: <your-repo-name>
# - Branch name: master
# - Nhấn Next

#Add build stage
# - Build provider: CodeBuild
# - Region: Singapore.
# - Project name: <Chọn project CodeBuild Java ở bài lab trước>
# - Nhấn Next

#Add deploy stage 
#Chọn Elastic Beanstalk, điền thông tin:
# - Application name: <your-app-name>
# - Environment name: <your-env-name>

#Review và nhấn Create pipeline.

#Step 4: Modify code, push lên Github.

#Step 5: Deploy & kiểm tra kết quả.
#truy cập pipeline java-beanstalk-cicd-pipeline, nhấn Release change.
#Chọn commit muốn release.
#Kiểm tra kết quả deploy thông qua domain của Elastic Beanstalk environment.


