resource "aws_apprunner_auto_scaling_configuration_version" "apprunner_auto_scaling_conf" {
  auto_scaling_configuration_name = "${var.service_name}-auto-scaling-conf-${var.env}"

  max_concurrency = 1
  max_size        = 1
  min_size        = 1

  tags = {
    Name = "${var.service_name}-apprunner-autoscaling-${var.env}"
  }
}

resource "aws_apprunner_service" "apprunner_service" {
  service_name = "${var.service_name}-apprunner-service-${var.env}"
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.apprunner_auto_scaling_conf.arn

  source_configuration {
    authentication_configuration {
      access_role_arn = var.apprunner_role.arn
    }
    auto_deployments_enabled = false
    image_repository {
      image_configuration {
        port = "3000"
      }
      image_identifier      = "${var.ecr.repository_url}:${var.repository_version}"
      image_repository_type = "ECR"
    }
  }

  tags = {
    Name = "${var.service_name}-apprunner-service-${var.env}"
  }
}

resource "aws_apprunner_custom_domain_association" "apprunner_domain_association" {
  domain_name = var.domain_name
  service_arn = aws_apprunner_service.apprunner_service.arn
}