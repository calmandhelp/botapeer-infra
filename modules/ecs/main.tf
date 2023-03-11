resource "aws_ecs_cluster" "api_cluster" {
  name = "${var.service_name}-api-cluster-${var.env}"
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
}

resource "aws_ecs_cluster_capacity_providers" "api_cluster_provider" {
  cluster_name = aws_ecs_cluster.api_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 1
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "api_task" {
  family = "${var.service_name}-task-${var.env}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn = var.execution_role.arn
  task_role_arn = var.execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.service_name}-core"
      image     = "${var.ecr.repository_url}:${var.repository_version}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      logConfiguration = {
        LogDriver = "awslogs"
        options = {
          "awslogs-region" = "ap-northeast-1"
          "awslogs-group" = "${var.ecs_task_group.name}"
          "awslogs-stream-prefix" = "streaming"
        }
    }
      # secrets = [
      #   {
      #     "name" : "TOKEN_FROM_SECRET_MANAGER",
      #     "valueFrom" : "arn:aws:secretsmanager:ap-northeast-1:123456789012:secret:token-json:json_key::"
      #   },
      #   {
      #     "name" : "TOKEN_FROM_PARAMERTER_STORE",
      #     "valueFrom" : "arn:aws:ssm:ap-northeast-1:123456789012:parameter/foo_token"
      #   }
      # ]
    }
  ])
}

resource "aws_ecs_service" "api_service" {
  name            = "${var.service_name}-api-ecs-service-${var.env}"
  cluster         = aws_ecs_cluster.api_cluster.id
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = 1

  network_configuration {
    subnets = [var.private_1a.id, var.private_1c.id]
    security_groups = [ aws_security_group.ecs_instance_sg.id ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_group.arn
    container_name   = "${var.service_name}-core"
    container_port   = 8080
  }
}