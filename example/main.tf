
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
  hosted_zone                       = var.hosted_zone
  subject_alternative_name_prefixes = var.subject_alternative_name_prefixes
  tags_extended                     = merge(var.tags_extended, { "info:time" = timestamp() })
}