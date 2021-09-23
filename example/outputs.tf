output "acm_certificate_arn" {
  value       = module.acm_route53_domain.acm_certificate_arn
  description = "The domain name used by your cloudfront distribution. If you are using the 'default_domain' variable, you would use this."
}

output "domain_name" {
  description = "Your root domain name. Must be unique, and already registered."
  value       = var.hosted_zone
}

output "fqdns_certified" {
  value = formatlist("%s.${var.hosted_zone}", var.subject_alternative_name_prefixes)
}

output "subject_alternative_name_prefixes" {
  description = "Alternative names for the domain. Wildcards mau be used. (*.example.com, etc)"
  value       = var.subject_alternative_name_prefixes
}
