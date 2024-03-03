# Create a file named nginx-nodeport.yaml
# Apply the configuration file to the Kubernetes cluster
kubectl apply -f mongo-cluster.yaml
# Check the Service & Deployment
kubectl get service
kubectl get service mongo-service -o wide
kubectl describe service mongo-service
kubectl get deployment
kubectl get pods -o wide


#Xoá resource:
kubectl delete -f mongo-cluster.yaml