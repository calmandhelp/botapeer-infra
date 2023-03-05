resource "aws_ecs_cluster" "api_cluster" {
  name               = "${var.service_name}-cluster-${var.env}"
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}