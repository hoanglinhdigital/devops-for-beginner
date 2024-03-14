#Triển khai một set ứng dụng đơn giản lên EKS
#YÊU CẦU: 
#  - Đã tạo thành công cluster ở lab1.
#  - Đã cài đặt eksctl, kubectl, aws cli, helm

#===Phần 1=========
#Follow guide sau để cài OIDC cho cluster:
https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
#Follow guide sau để cài đặt plugin ALB Ingress Controller
https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
#Apply ứng dụng Sample (2048 game):
https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html#application-load-balancer-sample-application

#Kiểm tra ALB được tạo ra, truy cập thử Game-2048 thông qua DNS của ALB (lưu ý thêm http:// trước DNS)
