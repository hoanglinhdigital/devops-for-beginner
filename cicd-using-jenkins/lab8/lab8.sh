#Sử dụng repository sau, LƯU Ý phải fork về github của bạn:
https://github.com/hoanglinhdigital/nodejs-random-color


#1. Add Jenkinsfile-auto vào repo, add phần build + deploy cho ECS (Job5+6).

#   Chỉnh sửa phần build tag thêm 1 tag "latest" cho ECR image.
#   Chỉnh sửa phần deploy deploy với version "latest“.
#   Push Jenkinsfile-auto mới lên repo.
#   *Chi tiết tham khảo file lab8.groovy

#2. Push file Jenkinsfile-auto lên repo.

#3. Cấu hình để Github có thể trigger Jenkins build job tự động (sd webhook)
#- Mở port 8080 cho security group của Jenkins allow all.
#- Cài đặt plugin Github trong Jenkins nếu chưa cài
#- Managed jenins -> Security -> Git host key... -> Accept first connection.​

#- Tạo một Build job có tên: Buildjob8-CICD-nodejs-auto
#- Trong cấu hình của Build Job, chọn "GitHub hook trigger for GITScm polling"
#- Pipeline form SCM, chọn Git, nhập URL của repository, chọn "Jenkinsfile-auto" trong "Script Path"
#- Branches to build: */develop
#- Save lại job.

#- Trong repository trên Github, vào "Settings" > "Webhooks" > "Add webhook"
#- Set "Payload URL" là http://<your-jenkins-url>/github-webhook/  *LƯU Ý phải có dấu / ở cuối URL
#- Set "Content type" là application/json
#- Chọn các event mà bạn muốn trigger webhook. click "Let me select individual events" và chọn "Pushes" và "Pull request"
#- Click "Add webhook" để lưu thay đổi.

#4. Test lại trigger build khi push code lên Github.
#Tạo nhánh develop
git checkout -b develop
#Modify một vài file code.
#Push code lên nhánh develop
git add .
git commit -m "Update code to demo Lab8"
git push origin develop






