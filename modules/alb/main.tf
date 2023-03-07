# resource "aws_lb" "alb" {
#   load_balancer_type = "application"
#   name               = "${var.service_name}-alb-${var.env}"

#   security_groups = ["${aws_security_group.ecs_instance_sg.id}"]
#   subnets         = ["${var.public_1a.id}", "${var.public_1c.id}"]
# }