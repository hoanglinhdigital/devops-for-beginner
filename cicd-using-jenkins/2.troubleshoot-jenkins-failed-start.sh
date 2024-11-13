#Sau bài lab Java nếu các bạn khởi động lại Jenkins mà gặp lỗi không khởi động được Jenkins, hãy thử các bước sau:
#1. Kiểm tra log của Jenkins
sudo systemctl status jenkins

#2. Kiểm tra log của Jenkins
sudo cat /var/log/jenkins/jenkins.log

#3. Kiểm tra Java version đang được set default bằng lệnh sau:
sudo update-alternatives --config java
#Kết quả trả về sẽ hiển thị các version của Java, ví dụ như dưới:
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                         Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-19-openjdk-amd64/bin/java   1911      auto mode
  1            /usr/lib/jvm/java-17-openjdk-amd64/bin/java   1711      manual mode
  2            /usr/lib/jvm/java-19-openjdk-amd64/bin/java   1911      manual mode
Press <enter> to keep the current choice[*], or type selection number:

#Trong trường hợp này Java của mình đang trỏ về version 19 (vị trí dấu *), còn Jenkins yêu cầu version 17, 
#nên mình sẽ chọn version 17 bằng cách gõ số 1 và nhấn enter.

#kiểm tra lại:
sudo update-alternatives --config java
#kết quả (Dấu * trỏ về số 1)
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                         Priority   Status
------------------------------------------------------------
  0            /usr/lib/jvm/java-19-openjdk-amd64/bin/java   1911      auto mode
* 1            /usr/lib/jvm/java-17-openjdk-amd64/bin/java   1711      manual mode
  2            /usr/lib/jvm/java-19-openjdk-amd64/bin/java   1911      manual mode

Press <enter> to keep the current choice[*], or type selection number: #Gõ Enter để bỏ qua.

#Chạy lệnh để start lại jenkins:
sudo systemctl restart jenkins
#Test truy cập trên browser bình thường.