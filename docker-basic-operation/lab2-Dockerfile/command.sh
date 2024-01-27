#Prepare Dockerfile as sample.
#Run below command to build image.
docker build -t my-httpd-image .
#check image
docker images
#Run below command to run container.
docker run -d -p 8080:80 --name my-httpd-container my-httpd-image
#Go to browser and check 
http://localhost:8080/index.html

