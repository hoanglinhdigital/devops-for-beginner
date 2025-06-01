#Require: re-use keypair from terraform section.

#Commands Terraform:
cd singapore-dev
#Chỉnh sửa file sau: singapore-dev/terraform.tfvars
#Dòng 6: ecr_repo_url ->chỉnh sửa thành url ECR repository của bạn ví dụ:
799227077423.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color-0529:latest

terraform init
terraform plan --var-file "terraform.tfvars"
terraform apply --var-file "terraform.tfvars"

#Clear resources:
terraform destroy --var-file "terraform.tfvars"
