output "vpc" {
  value = aws_vpc.vpc
}

output "public_1a" {
  value = aws_subnet.public_1a
}

output "public_1c" {
  value = aws_subnet.public_1c
}

output "private_1a" {
  value = aws_subnet.private_1a
}

output "private_1c" {
  value = aws_subnet.private_1c
}