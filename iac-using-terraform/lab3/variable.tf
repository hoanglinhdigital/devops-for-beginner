variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}
variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.micro"
  default = "t3.micro"
}
variable "region" {
  type = string
  default = "ap-southeast-1"
}
variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-0e4b5d31e60aa0acd"
    "ap-northeast-1" : "ami-0dfa284c9d7b2adad"
  }
}