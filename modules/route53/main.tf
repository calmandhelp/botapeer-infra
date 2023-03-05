data aws_route53_zone service_zone {
   name = "botapeer.com"
}

resource "aws_route53_zone" "subdomain_api" {
  name = "api.botapeer.com"
}

resource "aws_route53_zone" "subdomain_image" {
  name = "image.botapeer.com"
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