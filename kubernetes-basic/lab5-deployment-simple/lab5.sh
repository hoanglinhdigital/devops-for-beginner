# Tạo một file cấu hình Deployment cho service nginx
#   - Số lượng pod: 3
#   - Phương pháp deploy: RollingUpdate.
# Apply Deployment cho Kubernetes cluster.
kubectl apply -f nginx-deployment.yaml
# Get thông tin của Deployment & Replicaset
kubectl get deployment
kubectl get replicaset
kubectl get pods -o wide
# Tiến hành Update version cho image nginx
#  - Image mới: nginx:1.17.10
# Apply thay đổi cho Kubernetes cluster
kubectl apply -f nginx-deployment.yaml

# Kiểm tra trạng thái deployment:
kubectl rollout status deployment/nginx-deployment
# Kiểm tra thông tin của Deployment & Replicaset
kubectl get deployment
kubectl get replicaset
kubectl get pods -o wide

# Scale Deployment
#  - Số lượng pod: 5
kubectl scale --replicas=5 deployment/nginx-deployment
# Kiểm tra thông tin của Deployment & Replicaset
kubectl get deployment
kubectl get replicaset
kubectl get pods -o wide

# Tiến hành Rollback Deployment
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/nginx-deployment

# Kiểm tra trạng thái rollout status:
kubectl rollout status deployment/nginx-deployment

# Kiểm tra thông tin của Deployment & Replicaset
kubectl get deployment
kubectl describe deployment/nginx-deployment
kubectl get replicaset
kubectl get pods -o wide

#[Optional] Rollback to specific version
kubectl rollout history deployment/nginx-deployment
kubectl rollout undo deployment/<deployment-name> --to-revision=<revision-number>
#Ví dụ: 
kubectl rollout undo deployment/nginx-deployment --to-revision=2
kubectl rollout status deployment/nginx-deployment
kubectl describe deployment/nginx-deployment

# Xóa các resource đã tạo
kubectl delete -f nginx-deployment.yaml
kubectl get deployment
kubectl get replicaset
kubectl get pods -o wide