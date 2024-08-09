#Yêu cầu:​
#*Sử dụng lại resource của bài lab 6 và lab 7
# Modify job deploy, chuyển thành chiến lược deploy theo kiểu canary.​
# Cấu hình chiến lược deploy theo kiểu canary​
# Start: 25% nodes, Waiting time: 5 minutes.​
# Điều chỉnh số lượng task trong ECS lên 4 tasks.
# Update source code, push, kiểm tra kết quả trigger pipeline.
# Kiểm tra trạng thái của CodeBuild, CodeDeploy.
# Kiểm tra và truy cập thông qua ALB -> 25% request nhận version mới.​
# Đợi hết thời gian waiting -> truy cập ALB -> 100% traffic chuyển sang new version.