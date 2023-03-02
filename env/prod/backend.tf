terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56.0"
    }
  }
  backend "s3" {
    bucket  = "botapeer-terraform-state-prod"
    region  = "ap-northeast-1"
    key     = "prod.tfstate"
    encrypt = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "botapeer-terraform-state-${var.environment}"
}

resource "aws_s3_bucket_versioning" "versioning_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}