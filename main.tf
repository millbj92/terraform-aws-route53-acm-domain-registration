locals {
  subject_alternative_names = formatlist("%s.${var.hosted_zone}", var.subject_alternative_name_prefixes)
}

data "aws_route53_zone" "domain_name" {
  name         = var.hosted_zone
  private_zone = false
}

# This creates an SSL certificate
resource "aws_acm_certificate" "domain_name" {
  domain_name               = var.hosted_zone
  subject_alternative_names = local.subject_alternative_names
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}


resource "aws_route53_record" "route53_records" {
  for_each = {
    for dvo in aws_acm_certificate.domain_name.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain_name.zone_id
}


resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.domain_name.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_records : record.fqdn]
}