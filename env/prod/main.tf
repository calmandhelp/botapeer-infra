provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source        = "../../modules/vpc"
  cidr_vpc      = "10.0.0.0/16"
  cidr_public1a  = "10.0.1.0/24"
  cidr_public1c = "10.0.2.0/24"
  cidr_private1a = "10.0.11.0/24"
  cidr_private1c = "10.0.12.0/24"
  az1           = "ap-northeast-1a"
  az2           = "ap-northeast-1c"
  env           = var.environment
  service_name  = var.service_name
}

module "iam" {
  source       = "../../modules/iam"
  account_id = var.account_id
}

module "ec2" {
  source       = "../../modules/ec2"
  env          = var.environment
  service_name = var.service_name
  public_1a   = module.vpc.public_1a
  vpc_main     = module.vpc.vpc
}

module "ecs" {
  source       = "../../modules/ecs"
  env          = var.environment
  service_name = var.service_name
  vpc_main     = module.vpc.vpc
  alb_group = module.alb.alb_group
  ecr = module.ecr.ecr
  execution_role = module.iam.execution_role
  private_1a = module.vpc.private_1a
  private_1c = module.vpc.private_1c
  ecs_task_group = module.cloudwatch.ecs_task_group
  repository_version = "v6"
  account_id = var.account_id
}

module "route53" {
  source       = "../../modules/route53"
  env          = var.environment
  service_name = var.service_name
  cert = module.acm.cert
  alb = module.alb.alb
}

module "acm" {
  source       = "../../modules/acm"
  env          = var.environment
  service_name = var.service_name
}

module "ecr" {
  source       = "../../modules/ecr"
  env          = var.environment
  service_name = var.service_name
}

module "apprunner" {
  source       = "../../modules/apprunner"
  env          = var.environment
  service_name = var.service_name
  branch = "main"
  domain_name = "botapeer.com"
}

module "alb" {
  source       = "../../modules/alb"
  env          = var.environment
  service_name = var.service_name
  vpc_main     = module.vpc.vpc
  public_1a = module.vpc.public_1a
  public_1c = module.vpc.public_1c
  cert = module.acm.cert
  bucket_alb_log = module.s3.bucket_alb_log
}

module "cloudwatch" {
  source       = "../../modules/cloudwatch"
  env          = var.environment
  service_name = var.service_name
}

module "ssm" {
  source       = "../../modules/ssm"
  env          = var.environment
  service_name = var.service_name
  s3_access_key = var.s3_access_key
  s3_secret_key = var.s3_secret_key
  db_url = module.rds.rds.endpoint
  db_schema = var.db_schema
  datasource_url = var.datasource_url
  db_username = var.db_username
  db_password = var.db_password
  db_driver_classname = var.db_driver_classname
  region = var.region
  image_path = var.image_path
  jwt_secret = var.jwt_secret
  jwt_expiration = var.jwt_expiration
}

module "rds" {
  source = "../../modules/rds"
  env          = var.environment
  vpc_main     = module.vpc.vpc
  service_name = var.service_name
  public_1a = module.vpc.public_1a
  private_1a = module.vpc.private_1a
  private_1c = module.vpc.private_1c
  db_username = var.db_username
  db_password = var.db_password
  migrate_sg = module.ec2.migrate_instance
  ecs_instance_sg = module.ecs.ecs_instance_sg
}

module "s3" {
  source = "../../modules/s3"
  env          = var.environment
  service_name = var.service_name
  account_id = var.account_id
}