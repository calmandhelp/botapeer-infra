output "execution_role" {
  value = aws_iam_role.execution_role
}
output "apprunner_role" {
  value = aws_iam_role.apprunner_ecr_role
}