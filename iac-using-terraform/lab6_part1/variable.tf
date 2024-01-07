variable "region" {
  type = string
  default = "ap-southeast-1"
}
#parameters for networking module
variable "availability_zone_1" {
  type = string
  nullable = false
}
variable "availability_zone_2" {
  type = string
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