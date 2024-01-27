#Tạo một repo trên Github (private repository).
#Tạo một SSH key theo guide của Github. *Google keyword: “github create ssh key”
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows

#Tạo ssh key trên máy local. Mở Gitbash chạy lệnh sau. Thay email = email của bạn.
ssh-keygen -t ed25519 -C "your_email@example.com"
#Chọn nơi lưu key: mặc định sẽ là c:\Users\YOU\.ssh\id_ed25519. Enter nếu ko muốn thay đổi.
#Nhập Passphrase: Enter nếu ko muốn thay đổi.

#Cấu hình private key tại máy local.
##Mở Powershell dưới quyền admin. Windows -> Tìm kiếm -> Gõ Powershell -> Click chuột phải -> Run as administrator.
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
#Chạy không có lỗi là OK.

#Thêm private key vào ssh-agent. (Thay admin = user name của bạn)
ssh-add "C:\Users\admin\.ssh\id_ed25519"
#Xác nhận lại = lệnh sau, nếu hiện ra danh sách ssh key là OK.
ssh-add -L

#Add public key lên Github account setting.
##Copy nội dung file id_ed25519.pub.
##Trên Github Avatar bên góc phải: Settings -> SSH and GPG keys -> New SSH key -> Paste nội dung file id_ed25519.pub vào -> Add SSH key.

#Thử checkout một repo sử dụng SSH key. Thay repo URL bằng repo của bạn.
git clone git@github.com:hoanglinhdigital/demo-git-20240120.git