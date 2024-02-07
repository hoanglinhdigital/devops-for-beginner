#Sử dụng repository sau, LƯU Ý phải fork về github của bạn:
https://github.com/hoanglinhdigital/nodejs-random-color


#1. Tạo một pipeline job trong Jenkins với tên Buildjob7-CICD-nodejs-auto
#2. Trong pipeline job, sử dụng Pipeline để thực hiện các bước sau:
#- Checkout source code từ repository trên Git.
#- Sử dụng Dockerfile để build image
#- Push image lên AWS ECR với 2 tag: BUILD_NUMBER và latest
#- Update task definition và force deploy ECS (code của bài lab6)
#Chi tiết xem file lab7.groovy

#3. Cấu hình để Github có thể trigger Jenkins build job tự động (sd webhook)
#- Mở port 8080 cho security group của JEnkins allow all.
#- Cài đặt plugin Github trong Jenkins nếu chưa cài
#- Trong cấu hình của Build Job, chọn "GitHub hook trigger for GITScm polling"
#- Trong repository trên Github, vào "Settings" > "Webhooks" > "Add webhook"
#- Set "Payload URL" là http://<your-jenkins-url>/github-webhook/  *LƯU Ý phải có dấu / ở cuối URL
#- Set "Content type" là application/json
#- Chọn các event mà bạn muốn trigger webhook. click "Let me select individual events" và chọn "Pushes" và "Pull request"
#- Click "Add webhook" để lưu thay đổi.







