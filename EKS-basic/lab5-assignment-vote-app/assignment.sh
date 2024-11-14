#Trong bài assignment này, yêu cầu các bạn vận dụng các kiến thức đã học để triển khai một stack ứng dụng lên EKS.
#*Bạn nào làm hết các bài lab trong chương IaC using Terraform thì sẽ thấy khá quen thuộc tuy nhiên trong bài assignment này chúng ta sẽ sử dụng EKS để triển khai ứng dụng.
Repository: https://github.com/hoanglinhdigital/voteapp-k8s
#Ứng dụng bao gồm các thành phần sau:
    - Frontend Service (App React)
    - Backend Service (API code bằng Go)
    - Database Service (MongoDB) : triển khai bằng StatefulSet
    - Application Load Balancer (SD Load Balancer của AWS)
    - Persistent volume: Sử dụng EBS

#Các bước thực hiện:
1. Triển khai EKS cluster.
*Các bạn xem lại bài lab trong chương EKS để tạo một EKS Cluster, kết nối thành công tới cluster.

2. Triển khai ứng dụng voteapp-k8s lên EKS.

3. Test ứng dụng.


