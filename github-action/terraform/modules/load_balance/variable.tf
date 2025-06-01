variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "vpc_id" {
  type = string
  description = "The VPC ID to ALB and Target Group"
  nullable = false
}
variable "load_balance_subnet_ids" {
  type = list(string)
  description = "List of subnet to launch Application Load Balancer"
  nullable = false
}
variable "load_balance_security_group_ids" {
  type = list(string)
  description = "List of security group that applied to Application Load Balancer"
  nullable = false
}
