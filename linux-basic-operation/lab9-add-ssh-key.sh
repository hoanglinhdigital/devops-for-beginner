#SD Câu lệnh ssh key gen để tạo 1 cặp public +private key.
ssh-keygen -t rsa -b 4096 -C "dev01"

#Login vào server với ec2-user

#Tạo user dev01
sudo useradd dev01
#Không set password cho user.

#Switch sang user dev01
sudo su - dev01
#Kiểm tra thư mục đang đứng:
pwd
id

#Tạo thu mục .ssh
mkdir .ssh
chmod 700 .ssh
#Tạo file authorized_keys
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

#Edit file .ssh/authorized_keys
vim .ssh/authorized_keys
#Copy nội dung file dev01.pub vào file authorized_keys

#Thoat khoi user dev01
exit
#Restart service ssh
sudo service sshd restart
#Logout và login lại với user developer1 sử dụng private key. (Nhớ thay domain của ec2 server).
ssh -i "dev01" dev01@ec2-3-0-176-43.ap-southeast-1.compute.amazonaws.com
