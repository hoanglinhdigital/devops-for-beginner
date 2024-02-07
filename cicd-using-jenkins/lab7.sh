#Lab7: Cấu hình build với Pipelien from SCM cho Jenkins.
#Tạo ssh key bằng lệnh: ssh-keygen.exe​

#Add public key vào Github account.​
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

#Chỉnh setting của Github repository về private..​

#Managed jenins -> Security -> Git hot key... -> Accept first connection.​

#Tạo một Build job mới có tên "Buildjob7-pipeline-from-SCM", trong "Pipeline", chọn "Pipeline script from SCM"​

#Add credential "SSH username with private key" (sử dụng private key từ step 1).​

#Tạo một Jenkins file và push lên repo.​

#Chạy job build và kiểm tra kết quả.​
