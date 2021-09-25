terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.60.0"
    }
  }
}

provider "aws" {
  region = var.region
}


module "acm_route53_domain" {
  source                            = "./.."
  region                            = var.region
  hosted_zone                       = var.hosted_zone
  subject_alternative_name_prefixes = var.subject_alternative_name_prefixes
  #tags                              = merge(var.tags, { "info:time" = timestamp() })
}

