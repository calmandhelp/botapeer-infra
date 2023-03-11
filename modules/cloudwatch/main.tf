resource "aws_cloudwatch_log_group" "ecs_task" {
  name = "${var.service_name}-ecs-task-log-g-${var.env}"

  tags = {
    Environment = var.env
    Application = var.service_name
  }
}