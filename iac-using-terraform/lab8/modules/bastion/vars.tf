variable "instance_type" {
  type = string
  default = "t3.micro"
}
variable "ami" {
  type = string
}
variable "key_name" {
  type = string
  nullable = false
}

variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}
