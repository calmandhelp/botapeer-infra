resource "aws_ecs_cluster" "api_cluster" {
  name               = "${var.service_name}-cluster-${var.env}"
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
}