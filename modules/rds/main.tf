resource "aws_db_instance" "core_db" {
  identifier = "${var.service_name}-db-${var.env}"
  allocated_storage    = 10
  db_name              = "${var.service_name}_db"
  engine               = "mysql"
  engine_version       = "8.0.31"
  instance_class       = "db.t2.micro"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.service_name}-db_subnet_group-${var.env}"
  subnet_ids = [
    var.private_1a.id,
    var.private_1c.id
  ]
  tags = {
     Name = "${var.service_name}-db_subnet_group-${var.env}"
     Project = "${var.service_name}"
     Env = "${var.env}"
  }
}