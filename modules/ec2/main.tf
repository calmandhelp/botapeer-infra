resource "aws_instance" "migrate_instance" {
  ami                    = "ami-0329eac6c5240c99d"
  vpc_security_group_ids = [aws_security_group.migrate-instance-sg.id]
  subnet_id              = var.public_1a.id
  key_name               = aws_key_pair.key_pair.id
  instance_type          = "t2.micro"
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size = 8
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.service_name}-migrate-instance-${var.env}"
  }
}