# Trong bài lab này chúng ta sẽ thực hiện việc cấu hình để một Job Jenkins có thể notify kết quả build sang Slack channel.

# Bước 1: tạo Slack Channel
# - Đăng nhập vào Slack
# - Tạo một channel mới hoặc sử dụng channel đã có

# Bước 2: Add Jenkins CI app vào Slack channel
# - Đăng nhập vào Slack
# - Truy cập vào channel cần notify
# - Click vào "Add an app" -> "Browse App Directory"
# - Tìm kiếm "Jenkins CI" và chọn "Add to Slack"
# - Chọn channel cần notify và click "Add Jenkins CI integration"
# - Slack sẽ hiển thị một hướng dẫn giúp tichs hợp notification vào Slack. 
# - Copy "Webhook URL" và "Token" để sử dụng trong bước tiếp theo.
# - Click "Save Settings"

# Bước 3: Cài đặt plugin Slack Notification Plugin
# - Truy cập Jenkins Dashboard
# - Chọn "Manage Jenkins" -> "Manage Plugins"
# - Chọn tab "Available" và tìm kiếm "Slack Notification Plugin"
# - Chọn "Install"

# Bước 4: Cấu hình Slack Notification Plugin
# - Truy cập Jenkins Dashboard
# - Chọn "Manage Jenkins" -> "System"
# - Tìm đến phần "Slack"
# - Nhập Slack workspace name: vd "myworkspace"
# - Tạo một Credential với type: Secret text, và nhập "Token" đã copy ở bước 2
# - ID: nhập id ví dụ: slacktoken
# - Nhập channel name: vd "mychannel"
# - Click "Test Connection" để kiểm tra kết nối

# Bước 5: Cấu hình Job Jenkins, thêm bước Notification Slack.
# Tham khảo file lab11.groovy
# Để đơn giản, mình sẽ sử dụng lại bài Lab5 (không cần provision ra resource sd Terraform).