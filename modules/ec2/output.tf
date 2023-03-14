output "migrate_instance" {
  value = aws_security_group.migrate_instance_sg
}
output "public_dns" {
  value = aws_eip.eip.public_dns
}