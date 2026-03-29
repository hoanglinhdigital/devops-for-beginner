# CICD sử dụng GitOps và ArgoCD
Do đặc trưng của GitOps sẽ sử dụng Single Source of Truth. Nên chúng ta sẽ không sử dụng GithubAction để deploy trực tiếp lên EKS nữa. 
Thay vào đó, chúng ta sẽ sử dụng GithubAction để build và push Docker Image lên ECR và ArgoCD sẽ tự động deploy từ Git Repository.

Bạn cần chuẩn bị:
- Tạo 1 Github Repository để chứa code application(FE/BE) và file deploy.yml nơi cấu hình GitHub Action build docker image và push lên ECR (Tái sử dụng bài lab3)
- Tạo 1 Github Repository để chứa file aws-eks.yaml (Gọi là Manifest repository, cần tạo mới).
  Ví dụ tên repo: `todo-app-demo-gitops-manifests`

## Cài đặt ArgoCD

Step 1: Tạo namespace argocd
```bash
kubectl create namespace argocd
```

Step 2: Cài đặt ArgoCD
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Step 3: Test ArgoCD UI
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Step 4: Lấy mật khẩu của ArgoCD (username: admin)
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Step 5: Tạo ArgoCD Application
Thay thế URL Git trong file argocd-app.yaml bằng URL Git của bạn.
Ví dụ: `https://github.com/hoanglinhdigital/todo-app-demo-gitops-manifests.git`

Sau đó chạy lệnh sau để apply file argocd-app.yaml:
```bash
kubectl apply -f argocd-app.yaml
```

Step 6: Cấu hình credential cho ArgoCD để có thể truy cập vào Github Repository (Sử dụng GUI):

Vào mục Settings (biểu tượng bánh răng) -> Repositories.
Nhấn nút + Connect Repo.
Chọn phương thức: Via HTTPS.
Điền các thông tin:
    Type: git
    Repository URL: https://github.com/hoanglinhdigital/todo-app-demo-gitops-manifests.git (Lưu ý nên có đuôi .git).
    Username: Tên đăng nhập GitHub của bạn.
    Password: Nhập Personal Access Token (PAT) (Không phải mật khẩu đăng nhập GitHub).


## Chuẩn bị file deploy.yml mới cho repo chứa code application
* Tham khảo file: [deploy.yml]  
Những thay đổi trong lần này: 
  - Chuyển trigger của GithubAction từ auto sang manual. (Không còn push code là tự động deploy nữa)
  - Thêm input version để có thể deploy version cụ thể.
  - Sử dụng Tag của Docker Image thay vì sử dụng sha của commit.
  - Loại bỏ bước kubectl apply -f aws-eks.yaml (Vì đã có ArgoCD lo việc này)

## Test việc deploy CICD

Step 1: Modify code Backend & Frontend

Step 2: Commit, tag và push code lên Git
```bash
git add .
git commit -m "Update version v1.0.4 to adapt with ArgoCD"
git tag v1.0.4
git push origin v1.0.4
```

Step 3: Chạy GithubAction workflow
  - Truy cập vào Github Repository
  - Chọn Action
  - Chọn workflow deploy.yml
  - Chọn Run workflow
  - Nhập version: v1.0.2
  - Chọn Run workflow
  - Chờ cho đến khi workflow hoàn thành
  - Kiểm tra log của workflow
  - Kiểm tra Docker Image đã được push lên ECR Backend và Frontend thành công.

Step 4: Kiểm tra kết quả Docker Image với tag tương ứng đã được push lên ECR.

## Trong repository chứa Manifest, thực hiện các step sau:
Step 1: Tạo mục k8s-manifests làm nơi chứa file deploy mà ArgoCD sẽ đọc
Step 2: Copy file aws-eks.yaml từ thư mục gốc sang thư mục k8s-manifests
Step 3: Chỉnh sửa version mà bạn muốn deploy cho backend và frontend trong file aws-eks.yaml. Ví dụ: `v1.0.2`
Step 4: Commit và push file aws-eks.yaml lên Git

Step 5: Vào ArgoCD UI và sync application
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Access ArgoCD UI at: https://localhost:8080
Chọn applycation, nhấn nút Sync để ArgoCD deploy application.

Step 6: Kiểm tra kết quả ArgoCD đã deploy thành công

```bash
kubectl get pods -n default
```
Truy cập ứng dụng TODO và kiểm tra code mới đã được phản ánh.


# END.

