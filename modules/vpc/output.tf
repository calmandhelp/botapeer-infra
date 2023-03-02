output "vpc" {
  value = aws_vpc.vpc
}

output "public_1a" {
  value = aws_subnet.public_1a
}

output "private_1a" {
  value = aws_subnet.private_1a
}