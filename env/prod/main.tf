provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source        = "../../modules/vpc"
  cidr_vpc      = "10.0.0.0/16"
  cidr_public1  = "10.0.1.0/24"
  cidr_private1 = "10.0.11.0/24"
  az1           = "ap-northeast-1a"
  az2           = "ap-northeast-1c"
  env           = var.environment
  service_name  = var.service_name
}

module "ec2" {
  source = "../../modules/ec2"
}