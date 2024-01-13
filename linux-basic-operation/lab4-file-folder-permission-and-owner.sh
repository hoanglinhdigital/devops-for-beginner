#Lab4 - Làm quen với việc phân quyền file/folder và owner
#B1: Login vào server bằng user ec2-user
#B2 Gõ lệnh sau để check danh sách các file vd:
cd /etc
ls -l

#B3 Di chuyển sang thư mục /home/ec2-user
cd /home/ec2-user
#B4 Tạo thư mục test_folder
mkdir test_folder
#B5 Di chuyển vào thư mục test_folder
cd test_folder
#B6 Tạo file test_file.txt, nhập 1 số nội dung đơn giản.
vim test_file.txt
#save and quit bằng cách nhấn ESC, gõ :wq, enter

#B7 Gõ lệnh sau để check quyền, owner của file và folder
ls -l

#B8 Thay đổi quyền của file test_file.txt
chmod 750 test_file.txt
#Gõ lệnh ls -l để kiểm tra lại quyền của file test_file.txt
ls -l

#B9 add user developer1
sudo useradd developer1
#add password for user developer1
sudo passwd developer1
#Nhập password cho user developer1 2 lần sau đó Enter.

#B10 Tạo group developer_group
sudo groupadd developer_group
#Thêm user developer1 vào group developer_group
sudo usermod -a -G developer_group developer1
#Logout, login lại bằng user developer1
#Thử xem có truy cập dược file /home/ec2-user/test_folder/test_file.txt không? =>Kết quả báo không có quyền truy cập.


#B11 Login lại với user ec2-user
#Chuyển permission của thư mục /home/ec2-user thành 755
sudo chmod -R 755 /home/ec2-user

#Logout, login lại bằng user developer1
#Thử xem có truy cập dược file /home/ec2-user/test_folder/test_file.txt không? =>Truy cập được và xem được nội dung file.
cd /home/ec2-user/test_folder
cat tét_file.txt
