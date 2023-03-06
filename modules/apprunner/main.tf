resource "aws_apprunner_connection" "apprunner_connection" {
  connection_name = "${var.service_name}-apprunner-${var.env}"
  provider_type   = "GITHUB"
}

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
      connection_arn = aws_apprunner_connection.apprunner_connection.arn
    }
    auto_deployments_enabled = false
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "npm install --legacy-peer-deps && npm run build"
          port = "3000"
          runtime = "NODEJS_16"
          start_command = "npm run start"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/calmandhelp/botapeer-front"
      source_code_version {
        type  = "BRANCH"
        value = var.branch
      }
    }
  }

  tags = {
    Name = "${var.service_name}-apprunner-service-${var.env}"
  }
}