#Test build single stage with node:14
docker build -t tmp-nodejs -f Dockerfile-tmp .
#List images
docker images
#Check the size of image tmp-nodejs =>~900MB

#Test build multi stage with node:14 & nginx
docker build -t custom-httpd -f Dockerfile .
#List images
docker images
#Check the size of image tmp-nodejs =>~140MB

#=>Conclusion: Multi stage is better than single stage for image size.

#Thử chạy image được build ra.
docker run -d -p 8080:80 custom-httpd

#Test trên browser
http://localhost:8080

#Clear resources:
#list container
docker ps -a
#remove container
docker rm -f <container-id>
#list images
docker images
#remove images
docker rmi tmp-nodejs
docker rmi custom-httpd
docker rmi <image id>
