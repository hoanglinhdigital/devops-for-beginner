#Thiết kế và setting một Job Jenkins cho produciton với yêu cầu sau:
#Job release cần được trigger thủ công (không phải auto từ github).
#Code checkout theo một tag chỉ định trên nhánh master thay vì lấy mặc định.
#Có thể chọn BuildAndDeploy, OnlyBuild, OnlyDeploy cho job.
#Trong step deploy, tạm thời sd chiến lược force-deployment (all-in-one) cho ECS.

#*Mục đích chủ yếu làmquen với pipiline nên các bạn có thể sử dụng lại cluster ECS đã tạo ở các bài lab trước.

#1. Tạo một Job Jenkins có tên: Buildjob9-CICD-release-manual
#   - tick vào option: This project is parameterized.
#    +  Add parameter thứ hai, chọn String Parameter
#       Name: VERSION, Default Value: v0.0.1
#    +  Add parameter thứ nhất, chọn Choice Parameter
#       Name: ACTION, Choices: BuildAndDeploy, OnlyBuild, OnlyDeploy (Mỗi option là 1 hàng)

#   - Tham khảo file lab9.groovy, 
#      + Edit line số 4, FULL_IMAGE thành url của ECR repository của bạn.
#      + Edit line số 20, git url của project của bạn (sử dụng url của SSH).
#      + Edit line số 20, thêm thông tin của credential ID sẽ sử dụng để checkout code.

#   - Trong cấu hình Pipeline chọn Pipeline Script, dán nội dung của "lab9.groovy" vào.

#2. Test Job release:
#   - Update code trên nhánh master (push trực tiếp hay tạo PR từ nhánh develop đều được).
#   - Tạo tag mới trên nhánh master.
git checkout master
git pull
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0

#   - Build job with parameter,  điền VERSION & chọn ACTION tương ứng.
