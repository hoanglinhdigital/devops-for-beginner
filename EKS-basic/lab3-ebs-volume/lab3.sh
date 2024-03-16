#Follow guide sau để tiến hành cài đặt role và plugin  EBS:
https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html

#===Step 1: Tạo IAM Role cho EBS CSI Driver===
#LƯU Ý: thay thế tên clust của bạn vào chỗ --cluster
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster devops-test-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

#=============
#===Step 2: Cài đặt EBS CSI Driver add on===
#LƯU Ý: 
#  - thay thế tên clust của bạn vào chỗ --cluster
#  - thay thế ARN của role đã tạo ở bước trên vào chỗ --service-account-role-arn (hoặc chỉ thay account id nếu bạn không đổi tên role)
eksctl create addon --name aws-ebs-csi-driver --cluster devops-test-cluster --service-account-role-arn arn:aws:iam::430950558682:role/AmazonEKS_EBS_CSI_DriverRole --force


#===Step 3: Chuẩn bị một bộ resource có sử dụng Storage Class EBS, Persistent Volume Claim, gán vào mongodb

#===Step 4: apply resource cho cluster
kubectl apply -f demo-app.yaml

#Kiểm tra các resource tạo ra:
kubectl get storageclass
kubectl get pvc
kubectl get pv
kubectl get pods
kubectl get deployment
kubectl get service
kubectl get ingress

#Truy cập vào aws console để kiểm tra xem EBS volume đã được tạo ra chưa?
#Volume  có tên: devops-test-cluster-dynamic-pvc-xxxxx
#Volume size: 4GB

#===Step 5: Truy cập ứng dụng thông qua DNS của ALB

#===Step 6: Xoá thử 1 pod MongoDB, kiểm tra xem pod có được tạo lại không
kubectl get pods
kubectl delete pod <pod-name>

#===Step 7: Truy cập ứng dụng thông qua DNS của ALB, Kiểm tra xem data còn không?

#===Step 8: Xoá resource [Optional nếu các bạn không muốn tiếp tục sử dụng]
kubectl delete -f demo-app.yaml

#===Step 9: Xoá EKS Cluster (Hoặc giữ lại để thực hành luôn bài lab tiếp theo)
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1