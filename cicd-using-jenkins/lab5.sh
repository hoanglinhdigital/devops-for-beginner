#Sử dụng repository sau:
https://github.com/hoanglinhdigital/nodejs-random-color
#Các bạn có thể sử dụng trực tiếp hoặc fork về github của mình

#1. Tạo một pipeline job trong Jenkins
#2. Trong pipeline job, sử dụng Jenkinsfile để thực hiện các bước sau:
#- Checkout source code từ repository trên Git.
#- Sử dụng Dockerfile để build image
#- Push image lên AWS ECR
# Xem file lab5.groovy
#Trouble shoot error Permission denied
sudo usermod -a -G docker jenkins 
sudo systemctl restart jenkins




