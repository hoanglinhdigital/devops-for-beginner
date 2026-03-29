# Step by step to create EKS Cluster and connect to it

## 1. Create EKS Cluster

**Yêu cầu:** Tạo một EKS Cluster và kết nối tới.

### Nguồn tài liệu tham khảo:

**Phương án sử dụng AWS Console:**
- Các bạn có thể tham khảo guide sau: [AWS Console Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html)

**Phương án sử dụng EKSCTL:**
- Guide hướng dẫn gốc của AWS: [EKSCTL Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)

### Yêu cầu tiên quyết

Máy các bạn cần cài sẵn các công cụ sau (nên sử dụng `chocolatey` để cài `eksctl`, `kubectl` & `helm` cho Windows):
- **aws cli** (Chú ý không sử dụng version quá cũ!)
- **kubectl**: [Link cài đặt cho Windows](https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/)
- **eksctl**: [Link cài đặt cho Windows](https://eksctl.io/installation/)
- **helm**: [Link cài đặt](https://helm.sh/docs/intro/install/)

Kiểm tra version:
```bash
aws --version
kubectl version --client
eksctl version
helm version --short
```

---

### Step 1: Tạo EKS Cluster

Kiểm tra IAM user đã có quyền tạo EKS Cluster:
```bash
aws sts get-caller-identity
```

Tạo cluster có sẵn node group (Quá trình tạo cluster sẽ mất khoảng 10 phút):
```bash
cd cicd-for-kubernetes-eks/lab1-create-eks-cluster-and-connect

# Chỉnh sửa file cluster-config.yaml nếu muốn thay đổi tên cluster, region, số lượng node, loại instance...
# Chạy lệnh tạo cluster
eksctl create cluster -f cluster-config.yaml
```

*QUAN TRỌNG* Chạy lệnh sau để disable extended support cho EKS (giúp tiết kiệm chi phí):
```bash
aws eks update-cluster-config --name devops-test-cluster --upgrade-policy supportType=STANDARD
```

---

### Step 2: Cập nhật file config

Chạy lệnh sau để update file config trong thư mục `~/.kube/config` (Đối với Windows là: `C:\Users\{username}\.kube\config`):
```bash
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster
```

Check context:
```bash
kubectl config get-contexts
```

[Optional] Set context nếu có nhiều cluster và current context chưa đúng:
```bash
kubectl config use-context devops-test-cluster
```

Lấy thông tin cluster:
```bash
kubectl cluster-info
```
*Kết quả mẫu:*
```text
Kubernetes control plane is running at https://<8945378295HFEHFJRHEIWUO7549283>.gr7.ap-southeast-1.eks.amazonaws.com
CoreDNS is running at https://<8945378295HFEHFJRHEIWUO7549283>.gr7.ap-southeast-1.eks.amazonaws.com/api/v1/
```

---

### Step 3: Tạo node group (Optional)

**LƯU Ý:** Bỏ qua bước tạo node-group này nếu đã tạo cluster có node group ở *Step 1*.

Tạo node group gồm 2 node `t3.medium`:
```bash
eksctl create nodegroup \
  --cluster=devops-test-cluster \
  --region=ap-southeast-1 \
  --name=my-node-group \
  --node-type=t3.medium \
  --nodes=2 \
  --nodes-min=2 \
  --nodes-max=2 \
  --managed
```

---

### Step 4: Kiểm tra node

Đợi khoảng 5 phút, kiểm tra danh sách các node:
```bash
kubectl get nodes
```

## Phần 2: Cài đặt các công cụ cần thiết:

### Follow guide sau để cài OIDC cho cluster:
https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
### Follow guide sau để cài đặt plugin ALB Ingress Controller
https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
### Apply ứng dụng Sample (2048 game):
https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html#application-load-balancer-sample-application

### Kiểm tra ALB được tạo ra, truy cập thử Game-2048 thông qua DNS của ALB (lưu ý thêm http:// trước DNS)

## Phần 3: Cài đặt công cụ cần thiết cho EBS CSI Driver.
```bash
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster devops-test-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve
```
Đợi khoảng 3 phút.

*Lưu ý thay ACCOUNT ID = Account của các bạn.
```bash
eksctl create addon --name aws-ebs-csi-driver --cluster devops-test-cluster --service-account-role-arn arn:aws:iam::586098608758:role/AmazonEKS_EBS_CSI_DriverRole --force
```

## Phần 4: Xoá ứng dụng 2048
```bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/examples/2048/2048_full.yaml
```