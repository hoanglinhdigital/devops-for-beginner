#Thực hành làm quen với Docker qua các thao tác sau
#Pull một image từ docker registry (Docker Hub)
docker pull <image>:<tag>
#List image
docker images
#List all container
docker ps
#Run một container từ image
docker run -d -p <host port>:<container port> <image>:<tag>
#Một số ví dụ:
docker run -d -p 8080:80 nginx:latest

#Chạy container và tương tác trực tiếp dưới mode Interactive
docker run -it ubuntu:latest

#Chạy container và detach khỏi interactive mode tuy nhiên giữ cho container chạy ngầm và không bị exit.
docker run -dit ubuntu:latest

#List all container - All status
docker ps -a
#Start/Stop/Restart một container
docker start <container id>
docker stop <container id>
docker restart <container id>

#Delete một container
docker rm <container id>
#Force delete một container (kể cả đang chạy. *Cẩn thận khi dùng lệnh này)
docker rm <container id> -f
#Delete một image:
docker rmi <image>:<tag>
#Hoặc:
docker rmi <image id>
#SSH login vào một container đang chạy, vd Container chạy Ubuntu.
docker exec -it <container id> /bin/bash
