From: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html

### Yêu cầu: 
* Máy tính cài sẵn SAM CLI và AWS CLI
* Windows/Mac/Linux:
https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html
* Cài sẵn python 3.11

### Có thể kiểm tra bằng các lệnh sau nếu chưa chắc chắn:
`python --version`  
`sam --version`  
`aws --version`

### Step 1 - Chuẩn bị access key tại local cho AWS CLI, có thể kiểm tra lại bằng lệnh sau:
`aws sts get-caller-identity`

### Step 2 - Khởi tạo 1 sample app simple bằng lệnh sau:
*hoặc sử dụng luôn thư mục sam-app được cung cấp và bỏ qua step này.
`sam init --runtime python3.11`

### Step 2 - Build application. Di chuyển vào trong thư mục sam-app sau đó chạy lệnh build:
`cd <project folder>`  
`sam build`

### Step 3 - Deploy ứng dụng.
`sam deploy --guided`

### Step 4 - Kiểm tra resource trên console, thử access API bằng postman.
* Url (sample): `https://atyn41clp4.execute-api.ap-southeast-1.amazonaws.com/dev/generate-short-url`
* Body (sample):
```
{
    "url":"https://www.youtube.com/watch?v=FES2LsJvWzc"
}
```
* Truy cập thử link rút gọn (sample):
`https://atyn41clp4.execute-api.ap-southeast-1.amazonaws.com/dev/link/jDdfskaJKJ8f9d`

### Thử chỉnh sửa file python lambda và deploy lại
`sam build`  
`sam deploy --guided`

### Step 5 - Xoá resource bằng cách xoá CloudFormation stack trên console hoặc sd lệnh sau
`sam delete --stack-name sam-app`

### Thông tin thêm: sử dụng SAM để test API ở local.
`sam local start-api`
