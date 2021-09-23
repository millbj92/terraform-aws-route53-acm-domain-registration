# ACM_SSL_Certification

This module is used for the creation of ACM certificates, and verify them with the Route53 DNS. Plug in your domain name into the "hosted_zone" variable, and fill in the subject_alternative_name (SAN) prefixes array. These will be your subdomains. At the very least you probably want "www". The "*" should cover every subdomain, as it is a wildcard, but I prefer to be explicit about the subdomains I plan on creating.

'tags_extended' is a good way to keeping a consistent tagging schema in your organization. Essentially, define all mandatory tags in another module, and use the tags_extended map to consume those with a merge(), and then add any they may also need. You can check out how I'm doing it in [main.tf](main.tf).

### Usage:

 Example of 'acm_create_cert" module in `main.tf`.

 ```hcl
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
  source                            = "millbj92/route53-acm-domain-registration/aws"
  hosted_zone                       = "example.com"
  subject_alternative_name_prefixes = ["www", "*", "dev", "stg"]
  tags_extended                     = merge(var.tags_extended, { "info:time" = timestamp() })
}
 ```

*Please Note* While I have tried to follow the best security practices out-of-the-box, there is still some recommended setup. Please consider creating a WAF ([Web application Firewall](https://aws.amazon.com/waf/)) in front of your cloudfront distribution. It is highly recommended that you use one, especially in a production environment. That said, WAF's are very situation-specific, so I cannot guess how your setup should behave.
 [WAF Terraform Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl). Last but not least, you may also want to add a Lambda@Edge function between cloudfront and your bucket, to add an extra layer of security headers.

   #### Running the module

 To run the module, simply plug in the values below into a .tfvars file or export the equivalent env variables, and run the below commands

   - `terraform init`
   - `terraform plan` (make sure you like what you see on the console before going to the next step!)
   - `terraform apply`

&nbsp;
## Documentation
&nbsp;
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.route53_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.domain_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hosted_zone"></a> [hosted\_zone](#input\_hosted\_zone) | Route53 Hosted Zone | `string` | `null` | no |
| <a name="input_subject_alternative_name_prefixes"></a> [subject\_alternative\_name\_prefixes](#input\_subject\_alternative\_name\_prefixes) | Alternative names for the domain. Wildcards mau be used. (*.example.com, etc) | `list(string)` | <pre>[<br>  "www",<br>  "*",<br>  "dev",<br>  "stg"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on the resources. I recommend not modifying these. Instead, edit tags\_extended. | `map(string)` | <pre>{<br>  "info:moduleRepo": "https://github.com/millbj92/terraform-aws-route53-acm-domain-registration",<br>  "info:terraform": "true",<br>  "info:terraformModule": "millbj92/route53-acm-custom-domain/aws"<br>}</pre> | no |
| <a name="input_tags_extended"></a> [tags\_extended](#input\_tags\_extended) | Extra tags to be set on your | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The domain name used by your cloudfront distribution. If you are using the 'default\_domain' variable, you would use this. |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Your root domain name. Must be unique, and already registered. |
| <a name="output_subject_alternative_name_prefixes"></a> [subject\_alternative\_name\_prefixes](#output\_subject\_alternative\_name\_prefixes) | Alternative names for the domain. Wildcards mau be used. (*.example.com, etc) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->