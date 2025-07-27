# CI Test - Default
placeholder
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | 2.21.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfe_prereqs"></a> [tfe\_prereqs](#module\_tfe\_prereqs) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [random_bytes.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/bytes) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | ------------------------------------------------------------------------------ Logging ------------------------------------------------------------------------------ |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_tfe_database_password_secret_arn"></a> [tfe\_database\_password\_secret\_arn](#output\_tfe\_database\_password\_secret\_arn) | n/a |
| <a name="output_tfe_encryption_password_secret_arn"></a> [tfe\_encryption\_password\_secret\_arn](#output\_tfe\_encryption\_password\_secret\_arn) | n/a |
| <a name="output_tfe_license_secret_arn"></a> [tfe\_license\_secret\_arn](#output\_tfe\_license\_secret\_arn) | ------------------------------------------------------------------------------ Secrets Manager ------------------------------------------------------------------------------ |
| <a name="output_tfe_redis_password_secret_arn"></a> [tfe\_redis\_password\_secret\_arn](#output\_tfe\_redis\_password\_secret\_arn) | n/a |
| <a name="output_tfe_tls_ca_bundle_secret_arn"></a> [tfe\_tls\_ca\_bundle\_secret\_arn](#output\_tfe\_tls\_ca\_bundle\_secret\_arn) | n/a |
| <a name="output_tfe_tls_cert_secret_arn"></a> [tfe\_tls\_cert\_secret\_arn](#output\_tfe\_tls\_cert\_secret\_arn) | n/a |
| <a name="output_tfe_tls_privkey_secret_arn"></a> [tfe\_tls\_privkey\_secret\_arn](#output\_tfe\_tls\_privkey\_secret\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ------------------------------------------------------------------------------ Networking ------------------------------------------------------------------------------ |
<!-- END_TF_DOCS -->