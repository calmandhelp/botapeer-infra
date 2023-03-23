resource "aws_cloudfront_distribution" "distribution_service" {
  origin {
    domain_name              = "36guydmjsj.ap-northeast-1.awsapprunner.com"
    origin_id                = "${var.service_name}-cloudfront-${var.env}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = var.bucket_cloudfront.bucket_regional_domain_name
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.service_name}-cloudfront-${var.env}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
        restriction_type = "none"
    }
  }

  tags = {
    Environment = "${var.service_name}-cloudfront-${var.env}"
  }

  viewer_certificate {
    acm_certificate_arn = var.cert.arn
    ssl_support_method = "sni-only"
  }
}