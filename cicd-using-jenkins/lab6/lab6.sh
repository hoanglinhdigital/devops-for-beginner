#Lab6 - Tạo một job jenkins deploy ECS service từ bài lab5
#Bước 1: triển khai teraform stack
#Sử dụng teraform trong thư mục terraform để triển khai stack gồm:
# VPC Gồm 2 public subnet, 2 private subnet, 1 internet gateway, 1 nat gateway.
# Public security group, Private Security Group.
# ECS Cluster
# Task Definition
# ECS Service
# Load Balancer
# Target Group
# Tham khảo file terraform/command.txt

#Bước 2: Kiểm tra hoạt động của ECS thông qua ALB.

#Bước 3: Tạo một pipeline job trong Jenkins (Tham khảo file lab6.groovy)
#Job name: Buildjob6-deploy-ecs
#Update FULL_IMAGE thành ECR url của các bạn.
#Trong pipeline job, sử dụng Jenkinsfile để thực hiện các bước sau:
#Update task definition với image nhận version từ tham số parameter vd "ver-1", "ver-2", "latest"
#Update service với task definition mới
#Force deploy cho ECS Service

#Bước 4: Chạy job và kiểm tra kết quả

#=========TROUBLESHOOT LỖI "jq not found"=========
#Cài đặt jq trên Jenkins server
#sudo apt-get update
#sudo apt-get install jq

#Bước 5: Kiểm tra hoạt động của ECS thông qua ALB.

#---------------QUAN TRỌNG!!!!!---------------------
#Bước 6: Xóa stack terraform để tránh mất chi phí!!!
