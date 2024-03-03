kubectl apply -f nginx-replicaset.yaml
kubectl get pods
kubectl get pods -o wide
kubectl get replicaset
kubectl delete pod nginx-replicaset-<xxxx>
kubectl delete -f nginx-replicaset.yaml