# Yêu cầu:​
# *Sử dụng lại output của bài lab CodeBuild – Java project.​
# Tạo một Elastic Beanstalk Application+environment chạy Java, sử dụng file .jar của bài lab 2. Kiểm tra application chạy thành công.​
# Tạo một Job trong Code Deploy có nhiệm vụ deploy file war lên environment.​
# Modify code, chạy lại job build, kiểm tra artifact.​
# Chạy job CodeDeploy, kiểm tra và truy cập environment đã được cập nhật.​
#==========================================================================​

#Step 1: Set up ElasticBeanstalk environment
#Tạo một ElasticBeanstalk environment cho Java application.
#Chi tiết mời các bạn xem video.

#Step 2: Create an S3 bucket (bỏ qua nếu đã có sẵn artifact từ bài lab CodeBuild – Java project)

#Step 3: Tạo một IAM role cho CodeDeploy
#Tên IAM Role:
udemy-devops-codedeploy-role
#Attach policy:
S3Full
ElasticBeanstalkFull
EC2Full

#Step 4: Tạo một CodeDeploy application

#CodeDeploy ->Create Application
#Application name: udemy-devops-codedeploy-java-beanstalk

#Step 5: Create a deployment group

#In the CodeDeploy application, click on "Create deployment group".
#Provide a name for your deployment group and select the deployment type as "In-place".
#Chọn ElasticBeanstalk environment bạn đã tạo trước đó.
#Configure the deployment settings according to your requirements.

#STep 5: Modify code, build
#Modify code, thay đổi trang index.
#Chạy lại job build java project, kiểm tra artifact .jar được tạo ra.

#Step 7: Tạo một deployment
#Vào trong CodeDeploy application, click "Create deployment".
#Chọn deployment group bạn đã tạo trong step trước đó.
#Choose the revision type as "My application is stored in Amazon S3", nhập bucketname và key trỏ tới .jar file.
#Configure các setting khác theo yêu cầu.

#Step 8: Monitor the deployment
#Monitor tiến độ deployment trên CodeDeploy console.
#Sau khi deploy thành công, kiểm tra kết quả trên ElasticBeanstalk environment.