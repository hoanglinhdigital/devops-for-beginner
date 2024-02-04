#Command to build docker image (Lưu ý chạy command tại thư mục có chứa Dockerfile và index.html)

docker build -t my-httpd .

docker images

docker run -dit --name my-httpd-app -p 8080:80 my-httpd