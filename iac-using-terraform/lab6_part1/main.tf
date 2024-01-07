provider "aws" {
  region = var.region
}

#Create a complete VPC using module networking
module "networking" {
  source = "./modules/networking"
  region = var.region
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  cidr_block = var.cidr_block
  public_subnet_ips = var.public_subnet_ips
  private_subnet_ips = var.private_subnet_ips
}