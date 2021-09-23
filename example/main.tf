
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "acm_route53_domain" {
  source                            = "./.."
  domain_name                       = var.domain_name
  subject_alternative_name_prefixes = var.subject_alternative_name_prefixes
  hosted_zone                       = var.hosted_zone
  acm_certificate_domain            = var.acm_certificate_domain
  preprod_env_prefixes              = var.preprod_env_prefixes
}