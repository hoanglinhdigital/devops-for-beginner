#Thực hành: Thao tác với service
#Cài đặt httpd server, tạo 1 trang web đơn giản.
sudo yum -y update
sudo yum -y install httpd git

cd /var/www/html
rm *.html
sudo git clone https://github.com/cloudacademy/webgl-globe/ .
sudo cp -a src/* .
sudo rm -rf {.git,*.md,src,conf.d,docs,Dockerfile,index.nginx-debian.html}

sudo systemctl restart httpd

#Kiểm tra trạng thái service httpd
sudo systemctl status httpd
#Start/Stop/Restart service
sudo systemctl stop httpd
#Enable service khởi động cùng OS.
sudo systemctl enable httpd

#Tham khảo: disable service khởi động cùng OS.
sudo systemctl disable my-service

#Tham khảo: remove service:
sudo systemctl remove my-service