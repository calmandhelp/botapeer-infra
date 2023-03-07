resource "aws_ecs_cluster" "api_cluster" {
  name               = "${var.service_name}-api-cluster-${var.env}"
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
}

# resource "aws_ecs_task_definition" "api_task" {
#   family = "${var.service_name}-task-${var.env}"
#   container_definitions = jsonencode([
#     {
#       name      = "${var.service_name}-core"
#       image     = "${var.ecr.repository.repository_url}:v1"
#       cpu       = 0.25
#       memory    = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8080
#           hostPort      = 8080
#         }
#       ]
#     }
#   ])

#   placement_constraints {
#     type       = "memberOf"
#   }
# }

# resource "aws_ecs_service" "api_service" {
#   name            = "${var.service_name}-api-ecs-service-${var.env}"
#   cluster         = aws_ecs_cluster.api_cluster.id
#   task_definition = aws_ecs_task_definition.api_task.arn
#   desired_count   = 1
#   iam_role        = aws_iam_role.foo.arn
#   depends_on      = [aws_iam_role_policy.foo]

#   ordered_placement_strategy {
#     type  = "binpack"
#     field = "cpu"
#   }

#   load_balancer {
#     target_group_arn = var.alb_group.arn
#     container_name   = "mongo"
#     container_port   = 8080
#   }

#   placement_constraints {
#     type       = "memberOf"
#   }
# }