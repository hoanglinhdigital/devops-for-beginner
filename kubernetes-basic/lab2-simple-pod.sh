# Step 1: Create a pod
kubectl run nginx-pod --image=nginx

# Step 2: List pods
kubectl get pods
kubectl get pods -o wide

# Step 3: Get pod details
kubectl describe pod nginx-pod

# Step 4: Delete the pod
kubectl delete pod nginx-pod
