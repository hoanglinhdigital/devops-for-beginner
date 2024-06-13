From: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html

# Yêu cầu: 
# Máy tính cài sẵn SAM CLI và AWS CLI
# Windows/Mac/Linux:
https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html
# Cài sẵn python 3.11

# Step 1 - Chuẩn bị access key tại local cho AWS CLI, có thể kiểm tra lại bằng lệnh sau:
aws sts get-caller-identity

# Step 2 - Khởi tạo 1 sample app simple bằng lệnh sau:
#  *hoặc sử dụng luôn thư mục sam-app được cung cấp và bỏ qua step này.
sam init --runtime python3.11

# Step 2 - Build application. Di chuyển vào trong thư mục sam-app sau đó chạy lệnh build:
cd <project folder>
sam build

# Step 3 - Deploy ứng dụng.
sam deploy --guided

# Step 4 - Kiểm tra resource trên console, thử access API bằng postman.

# Chỉnh sửa file python lambda và deploy lại
sam build
sam deploy --stack-name sam-demo-1 --parameter-overrides Stage=Stage

# Step 5 - Xoá resource bằng cách xoá CloudFormation stack trên console hoặc sd lệnh sau
sam delete --stack-name sam-demo-1

# Thông tin thêm: sử dụng SAM để test API ở local.
sam local start-api
