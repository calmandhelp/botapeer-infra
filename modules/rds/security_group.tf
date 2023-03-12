resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "db-sg"
  vpc_id      = var.vpc_main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.public_1a.cidr_block]
    security_groups = [var.migrate_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}