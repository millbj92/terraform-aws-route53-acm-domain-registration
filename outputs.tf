output "acm_certificate_arn" {
  value       = aws_acm_certificate_validation.cert_validation.certificate_arn
  description = "The domain name used by your cloudfront distribution. If you are using the 'default_domain' variable, you would use this."
}

output "domain_name" {
  description = "Your root domain name. Must be unique, and already registered."
  value       = var.hosted_zone
}

output "subject_alternative_name_prefixes" {
  description = "Alternative names for the domain. Wildcards mau be used. (*.example.com, etc)"
  value       = var.subject_alternative_name_prefixes
}
