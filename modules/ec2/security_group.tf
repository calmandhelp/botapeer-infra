resource "aws_security_group" "migrate_instance_sg" {
  name        = "migrate-instance-sg"
  description = "migrate-instance-sg"
  vpc_id      = var.vpc_main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "migrate-instance-sg"
  }
}