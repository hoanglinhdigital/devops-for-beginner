#Cho phép login = username/password.
#B1: Login với user ec2-user (như bài lab1)
#B2: Thay đổi setting SSH bằng lệnh sau:
sudo vi /etc/ssh/sshd_config

#Sửa giá trị sau từ no thành yes
PasswordAuthentication

#Save file lại. (Nhấn ESC, gõ :wq, enter)

#B3: Restart SSH service
sudo service sshd restart

#B4: Tạo user mới với tên developer1
sudo useradd developer1
#Thay đổi password cho user developer1
sudo passwd developer1
#Nhập password cho user developer1 2 lần sau đó Enter.

#B5 Logout khỏi server bằng lệnh exit
exit

#B6: Login lại server với user developer1
#Lưu ý thay ec2-xxxxx.amazon.com bằng domain của server của các bạn.
ssh developer1@ec2-3-0-176-43.ap-southeast-1.compute.amazonaws.com
#nhập password của developer1 sau đó Enter.
#Gõ lệnh whoami để kiểm tra user hiện tại.
whoami

#=======Cấp quyền sudoer cho user developer1
#B1: Login lại vào server với user ec2-user
ssh -i "<your key>" ec2-user@<Your server domain>.ap-southeast-1.compute.amazonaws.com
#B2 tạo nhóm developer_group
sudo groupadd developer_group
#B3 thêm user developer1 vào nhóm developer_group
sudo usermod -a -G developer_group developer1

#B4: Gõ lệnh sau sẽ mở ra 1 trình editor VIM
sudo visudo
#Thêm dòng sau vào dưới chỗ wheel ALL=(ALL) ALL
%developer_group ALL=(ALL) ALL 
#Save file lại. (Nhấn ESC, gõ :wq, enter)

#B5 Exit khỏi server
exit

#B6: Login lại bằng user developer1
#Lưu ý thay ec2-xxxxx.amazon.com bằng domain của server của các bạn.
ssh developer1@ec2-3-0-176-43.ap-southeast-1.compute.amazonaws.com

#B7 Gõ whoami để kiểm tra user hiện tại
whoami

#B8 Gõ sudo su để chuyển sang user root
sudo su
#Gõ password của user developer1 sau đó Enter.
#Con trỏ chuyển sang có chữ "root" va dấu # là thành công.
[root@ip-172-31-31-218 developer1]#

#===Xóa user và group
#Login lại với user ec2-user
sudo userdel developer1
sudo groupdel developer_group