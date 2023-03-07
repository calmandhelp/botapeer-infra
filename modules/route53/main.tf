data aws_route53_zone service_zone {
   name = "botapeer.com"
}

resource "aws_route53_zone" "subdomain_api" {
  name = "api.botapeer.com"
}

resource "aws_route53_zone" "subdomain_image" {
  name = "image.botapeer.com"
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in var.cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.service_zone.zone_id
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = var.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

resource "aws_route53_record" "ns_record_for_subdomain_api" {
  name    = aws_route53_zone.subdomain_api.name
  zone_id = data.aws_route53_zone.service_zone.id
  records = [
    aws_route53_zone.subdomain_api.name_servers[0],
    aws_route53_zone.subdomain_api.name_servers[1],
    aws_route53_zone.subdomain_api.name_servers[2],
    aws_route53_zone.subdomain_api.name_servers[3]
  ]
  ttl  = 300
  type = "NS"
}

resource "aws_route53_record" "ns_record_for_subdomain_image" {
  name    = aws_route53_zone.subdomain_image.name
  zone_id = data.aws_route53_zone.service_zone.id
  records = [
    aws_route53_zone.subdomain_image.name_servers[0],
    aws_route53_zone.subdomain_image.name_servers[1],
    aws_route53_zone.subdomain_image.name_servers[2],
    aws_route53_zone.subdomain_image.name_servers[3]
  ]
  ttl  = 300
  type = "NS"
}

resource "aws_route53_record" "alb_record" {
  name    = aws_route53_zone.subdomain_api.name
  zone_id = data.aws_route53_zone.service_zone.id
  type    = "A"
 
  alias {
    name                   = var.alb.dns_name
    zone_id                = var.alb.zone_id
    evaluate_target_health = true
  }
}