variable "availability_zones" {
  type = list(any)
}
variable "vpc_name" {
  type = string  
}
variable "cidr_block" {
  type = string
}
variable "public_subnet_ips" {
  type = list(string)
  description = "List of public subnet IPs CIDR"
}
variable "private_subnet_ips" {
  type = list(string)
  description = "List of private subnet IPs CIDR"
}