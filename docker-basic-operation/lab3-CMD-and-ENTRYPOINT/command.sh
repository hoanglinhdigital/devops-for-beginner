#Chạy command sau để inspect một Image, chú ý khu vực Entrypoint:
docker pull alpine:latest
docker inspect alpine:latest

#=======Build Image from Dockerfile số 1 =======
docker build -t alpine-1 -f Dockerfile-1 .
docker inspect alpine-1
#Chạy docker container từ image alpine-1 và không chỉ định param
docker run alpine-1
#=>Expect output sẽ là kết quả nhu khi gõ lệnh "ls"

#Chạy docker container từ image alpine-1 và  chỉ định param "-alh"
docker run alpine-1 -alh
#=>Expect output sẽ là kết quả nhu khi gõ lệnh "ls" với param "-alh" được thêm vào.


#=======Build Image from Dockerfile số 2 =======
docker build -t alpine-2 -f Dockerfile-2 .
docker inspect alpine-2
#Chạy docker container từ image alpine-1 và không chỉ định param
docker run alpine-2
#=>Expect output sẽ là kết quả nhu khi gõ lệnh "ls"

#Chạy docker container từ image alpine-1 và  chỉ định param "-alh"
docker run alpine-2 -alh
#=>Expect output BÁO LỖI! vì không thể chạy câu lệnh. Lúc này docker hiểu "ls" là param mặc định và "-alh" là param được truyền vào tại thời điểm run.
#Khi có param tại thời điểm run, nó sẽ ghi đè lên param mặc định. kết quả câu lệnh sẽ là "-alh" thay vì "ls -alh" => lỗi.


#=======Build Image from Dockerfile số 3 =======
docker build -t alpine-3 -f Dockerfile-3 .
docker inspect alpine-3

#Chạy docker container từ image alpine-1 và không chỉ định param
docker run alpine-3
#=>Expect output sẽ là kết quả nhu khi gõ lệnh "ls -alh"

#Chạy docker container từ image alpine-1 và  chỉ định param "-alh"
docker run alpine-3 -p --full-time
#=>Expect output sẽ là kết quả nhu khi gõ lệnh "ls --full-time"