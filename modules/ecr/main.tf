resource "aws_ecr_repository" "service_ecr" {
  name                 = "${var.service_name}-ecr-${var.env}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "front_ecr" {
  name                 = "${var.service_name}-front-ecr-${var.env}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}