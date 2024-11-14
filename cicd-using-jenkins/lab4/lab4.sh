#Build một Nodejs project
#Chuẩn bị:
#Cài đặt Nodejs, tham khảo guide: 
https://www.stewright.me/2023/04/install-nodejs-18-on-ubuntu-22-04/

#Danh sách câu lệnh:
sudo apt install curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt install nodejs

#kieeemr tra version
node --version
#ket qua:
v18.19.0

#Fork một project từ github (project sample của mình)
https://github.com/hoanglinhdigital/simple-vue-webpack.git
#Tạo một job mới với type "Pipeline" với tên như sau:
Buildjob4-simple-vue-webpack-project

#Cấu hình pipeline script:
#Xem file lab4.groovy
