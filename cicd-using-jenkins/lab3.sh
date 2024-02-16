#Cấu hình Java cho Jenkins
#chạy lệnh:
javac
#Chạy câu lệnh sau để tìm java home
java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' 

#Truy cập vào Jenkins -> Manage Jenkins -> Tool
#Ở khu vực JDK Installation, chọn Add JDK, điền tên và path tới JAVA HOME, ví dụ:
/usr/lib/jvm/java-19-openjdk-amd64

#Cấu hình Maven cho Jenkins
#Truy cập vào Jenkins -> Manage Jenkins -> Tool
#Ở khu vực Maven Installation, chọn Add Maven, điền tên và path tới Maven, ví dụ:
#Nhấn Add installer chọn "Install from Apache"
#Chọn version maven, ví dụ: 3.9.6
#Click Save.

#Tạo một job java mới
Buildjob3-simple-Java-project

#Link git hub repo:
https://github.com/hoanglinhdigital/simple-java-maven-app.git

#Nhánh:
*/main

#Build steps: thêm "Invoke top-level Maven targets"
#MavenVersion: chọn maven version đã cài đặt
#Goals: 
clean install

#Add Thêm IAM Role cho Jenkins, add policy "S3FullAccess"

#Add thêm step upload to S3
#Shell script
aws s3 cp "${WORKSPACE}/target/my-app-1.0-SNAPSHOT.jar" "s3://udemy-jenkins-linh/jenkins/${BUILD_ID}/"
