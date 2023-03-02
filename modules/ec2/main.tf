resource "aws_instance" "migrate_instance" {
  ami                    = "ami-0329eac6c5240c99d"
  vpc_security_group_ids = [aws_security_group.migrate-instance-sg.id]
  subnet_id              = var.private_1a.id
  key_name               = aws_key_pair.key_pair.id
  instance_type          = "t2.micro"
  root_block_device {
    delete_on_termination = true
  }
  tags = {
    Name = "${var.service_name}-migrate-instance-${var.env}"
  }
}