terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
#tfsec:ignore:aws-ec2-no-public-ip-subnet
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = var.cidr_block
  azs             = var.availability_zones
  public_subnets  = var.public_subnet_ips
  private_subnets = var.private_subnet_ips

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = var.vpc_name
  }
}
