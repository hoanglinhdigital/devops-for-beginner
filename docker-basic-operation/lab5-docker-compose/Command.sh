#Start docker compose
docker-compose -f docker-compose.yaml up -d
#OR
#Start and rebuild all docker images
docker-compose -f docker-compose.yaml up -d --build

#Check container:
docker ps -a
#OR
docker-composse ps -a
#Terminate all resource
docker-compose -f docker-compose.yaml down

