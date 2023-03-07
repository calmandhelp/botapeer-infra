resource "aws_lb_target_group" "alb_group" {
  name        = "${var.service_name}-alb-tg-${var.env}"
  target_type = "ip"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_main.id

  health_check {
    path     = "/api/users"
    protocol = "HTTP"
  }

  tags = {
    Environment = "${var.service_name}-alb-tg-${var.env}"
  }
}

resource "aws_lb" "alb" {
  load_balancer_type = "application"
  name               = "${var.service_name}-alb-${var.env}"

  security_groups = ["${aws_security_group.ecs_alb_sg.id}"]
  subnets         = ["${var.public_1a.id}", "${var.public_1c.id}"]

  tags = {
    Environment = "${var.service_name}-alb-${var.env}"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_group.arn
  }
}