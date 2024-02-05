terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  # Để cho bài lab đơn giản và không mất công chuẩn bị S3, DynamoDB, tôi sẽ không sử dụng remote state
  # backend "s3" {
  #   bucket         = "udemy-terraform-state-singapore-linh"
  #   key            = "udemy-terraform"
  #   region         = "ap-southeast-1"
  #   dynamodb_table = "udemy-terraform-state"
  # }
}

provider "aws" {
  region = var.region
}


#Create a complete VPC using module networking
module "networking" {
  source              = "../modules/networking"
  region              = var.region
  availability_zones  = var.availability_zones
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
  private_subnet_ips  = var.private_subnet_ips
}

module "security" {
  source = "../modules/security"
  region = var.region
  vpc_id = module.networking.vpc_id
  depends_on = [module.networking]
}

module "load-balance" {
  source                 = "../modules/load-balance"
  region                 = var.region
  vpc_id                 = module.networking.vpc_id
  load_balance_subnet_ids = module.networking.public_subnet_ids
  load_balance_security_group_ids = module.security.public_security_group_id

  depends_on = [ module.networking, module.security]
}

module "ecs-cluster"{
  source = "../modules/ecs-cluster"
  region = var.region
  vpc_id = module.networking.vpc_id
  ecs_subnet_ids = module.vpc.private_subnet_ids
  ecs_security_group_ids = module.security.private_security_group_id
  alb_arn = module.load-balance.alb_arn
  nodejs_target_group_arn = module.load-balance.target_group_arn
  nodejs_ecr_image_url = var.ecr_repo_url

  depends_on = [ module.networking, module.security, module.load-balance]
}
