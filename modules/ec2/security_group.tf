resource "aws_security_group" "migrate-instance-sg" {
  name        = "migrate-instance-sg"
  description = "for migrate sg"
  vpc_id      = var.vpc_main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}