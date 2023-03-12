resource "aws_ssm_parameter" "s3_access_key" {
  name        = "/s3/access_key"
  description = "S3_ACCESS_KEY"
  type        = "SecureString"
  value       = var.s3_access_key

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "s3_secret_key" {
  name        = "/s3/secret_key"
  description = "S3_SECRET_KEY"
  type        = "SecureString"
  value       = var.s3_secret_key

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "db_url" {
  name        = "/${var.env}/rds/db_url"
  description = "DB_URL"
  type        = "SecureString"
  value       = var.db_url

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "db_schema" {
  name        = "/${var.env}/rds/db_schema"
  description = "DB_SCHEMA"
  type        = "SecureString"
  value       = var.db_schema

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "datasource_url" {
  name        = "/${var.env}/rds/datasource_url"
  description = "SPRING_DATASOURCE_URL"
  type        = "SecureString"
  value       = var.datasource_url

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.env}/rds/db_username"
  description = "DB_USERNAME"
  type        = "SecureString"
  value       = var.db_username

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.env}/rds/db_password"
  description = "DB_PASSWORD"
  type        = "SecureString"
  value       = var.db_password

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "db_driver_classname" {
  name        = "/${var.env}/rds/db_driver_classname"
  description = "DB_DRIVER_CLASS_NAME"
  type        = "SecureString"
  value       = var.db_driver_classname

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "region" {
  name        = "/${var.env}/aws/region"
  description = "AWS_REGION_STATIC"
  type        = "SecureString"
  value       = var.region

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "image_path" {
  name        = "/${var.env}/s3/image_path"
  description = "IMAGE_PATH"
  type        = "SecureString"
  value       = var.image_path

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/${var.env}/spring/jwt_secret"
  description = "JWT_SECRET"
  type        = "SecureString"
  value       = var.jwt_secret

  tags = {
    environment = "${var.env}"
  }
}

resource "aws_ssm_parameter" "jwt_expiration" {
  name        = "/${var.env}/spring/jwt_expiration"
  description = "JWT_EXPIRATION_IN_MS"
  type        = "SecureString"
  value       = var.jwt_expiration

  tags = {
    environment = "${var.env}"
  }
}