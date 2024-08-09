variable "region" {
  type = string
  default = "ap-southeast-1"
}

#parameters for networking module
variable "availability_zones" {
  type = list(string)
  nullable = false
}
variable "cidr_block" {
  type = string
  nullable = false
}
variable "public_subnet_ips" {
  type = list(string)
  nullable = false
  
}
variable "private_subnet_ips" {
  type = list(string)
  nullable = false
}

variable "ecr_repo_url" {
  type = string
  description = "The URI of the ECR repository for the Node.js application"
  nullable = false
}