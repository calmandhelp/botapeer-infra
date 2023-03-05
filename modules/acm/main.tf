resource "aws_acm_certificate" "cert" {
  domain_name       = "*.botapeer.com"
  validation_method = "DNS"
  tags = {
    Name = "${var.service_name}-acm-cert-${var.env}"
  }
  lifecycle {
    create_before_destroy = true
  }
}