

variable "subject_alternative_name_prefixes" {
  description = "Alternative names for the domain. Wildcards may be used. (*.example.com, etc)"
  type        = list(string)
  default     = null
}

variable "hosted_zone" {
  description = "Route53 Hosted Zone"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "tags" {
  description = "Tags to set on the resources. I recommend not modifying these. Instead, edit tags_extended."
  type        = map(string)
  default = {
    "info:terraform"       = "true"
    "info:terraformModule" = "millbj92/route53-acm-custom-domain/aws"
    "info:moduleRepo"      = "https://github.com/millbj92/terraform-aws-route53-acm-domain-registration"
  }
}