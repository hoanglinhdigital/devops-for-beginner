eksctl delete cluster --name devops-test-cluster --region ap-southeast-1

#Workaround cho lỗi: "pods are unevictable". Chạy các lệnh sau để xoá các PodDisruptionBudget (PDB) trong cluster.
kubectl get pdb -A
#Xoá các pdb có trong kube-system (thường là coredns và metrics-server)
kubectl delete pdb coredns -n kube-system
kubectl delete pdb metrics-server -n kube-system

#Nếu vẫn không được, thử lại với lệnh:
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1 --disable-nodegroup-eviction