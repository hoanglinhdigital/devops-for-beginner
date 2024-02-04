#-------------------------------------------
#Lab7 - Docker compose with load balancer
#Start docker compose
docker-compose -f docker-compose-load-balance.yaml up -d
#[Optional] Force rebuild dockerfile.
docker-compose -f docker-compose-load-balance.yaml up -d --build
#Terminate all resource
docker-compose -f docker-compose-load-balance.yaml down

