output "service_ecr" {
  value = aws_ecr_repository.service_ecr
}

output "front_ecr" {
  value = aws_ecr_repository.front_ecr
}