# Consul Enterprise Example

This module is an example of utilizing this module as part of the HashiCorp Validated Design prerequisite Solution Design Guide. Users can use this to deploy prerequisite infrastructure required to install Consul into AWS.

After having all resources deployed, you can use the following module [terraform-aws-consul-enterprise-hvd](https://github.com/hashicorp/terraform-aws-consul-enterprise-hvd) to continue installing Consul Enterprise as described in HashiCorp Validated Design.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prereqs"></a> [prereqs](#module\_prereqs) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.consul_ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server_ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.consul_ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_cidr_allow_ingress_ssh"></a> [bastion\_cidr\_allow\_ingress\_ssh](#input\_bastion\_cidr\_allow\_ingress\_ssh) | List of source CIDR ranges to allow inbound to bastion on port 22 (SSH). | `list(string)` | `[]` | no |
| <a name="input_bastion_ec2_keypair_name"></a> [bastion\_ec2\_keypair\_name](#input\_bastion\_ec2\_keypair\_name) | Existing SSH key pair to use for bastion EC2 instance. | `string` | `null` | no |
| <a name="input_boundary_database_password_secret_name"></a> [boundary\_database\_password\_secret\_name](#input\_boundary\_database\_password\_secret\_name) | Name of AWS Secrets Manager secret for Boundary database password. | `string` | `"boundary-database-password"` | no |
| <a name="input_boundary_database_password_secret_value"></a> [boundary\_database\_password\_secret\_value](#input\_boundary\_database\_password\_secret\_value) | Value of Boundary Database Password create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_boundary_license_secret_name"></a> [boundary\_license\_secret\_name](#input\_boundary\_license\_secret\_name) | Name of AWS Secrets Manager secret for Boundary license. | `string` | `"boundary-license"` | no |
| <a name="input_boundary_license_secret_value"></a> [boundary\_license\_secret\_value](#input\_boundary\_license\_secret\_value) | Raw contents of the Boundary license file to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_boundary_tls_ca_bundle_secret_name"></a> [boundary\_tls\_ca\_bundle\_secret\_name](#input\_boundary\_tls\_ca\_bundle\_secret\_name) | Name of AWS Secrets Manager secret for Boundary TLS CA bundle. | `string` | `"boundary-tls-ca-bundle-base64"` | no |
| <a name="input_boundary_tls_ca_bundle_secret_value_base64"></a> [boundary\_tls\_ca\_bundle\_secret\_value\_base64](#input\_boundary\_tls\_ca\_bundle\_secret\_value\_base64) | Base64-encoded string value of Boundary TLS CA bundle in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_boundary_tls_cert_secret_name"></a> [boundary\_tls\_cert\_secret\_name](#input\_boundary\_tls\_cert\_secret\_name) | Name of AWS Secrets Manager secret for Boundary TLS certificate. | `string` | `"boundary-tls-cert-base64"` | no |
| <a name="input_boundary_tls_cert_secret_value_base64"></a> [boundary\_tls\_cert\_secret\_value\_base64](#input\_boundary\_tls\_cert\_secret\_value\_base64) | Base64-encoded string value of Boundary TLS certificate in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_boundary_tls_privkey_secret_name"></a> [boundary\_tls\_privkey\_secret\_name](#input\_boundary\_tls\_privkey\_secret\_name) | Name of AWS Secrets Manager secret for Boundary TLS private key. | `string` | `"boundary-tls-privkey-base64"` | no |
| <a name="input_boundary_tls_privkey_secret_value_base64"></a> [boundary\_tls\_privkey\_secret\_value\_base64](#input\_boundary\_tls\_privkey\_secret\_value\_base64) | Base64-encoded string value of Boundary TLS private key in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | Name of CloudWatch Log Group for log forwarding destination. | `string` | `"log-group"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_consul_license_secret_name"></a> [consul\_license\_secret\_name](#input\_consul\_license\_secret\_name) | Name of AWS Secrets Manager secret for Consul license. | `string` | `"consul-license"` | no |
| <a name="input_consul_license_secret_value"></a> [consul\_license\_secret\_value](#input\_consul\_license\_secret\_value) | Raw contents of the Consul license file to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_consul_tls_ca_bundle_secret_name"></a> [consul\_tls\_ca\_bundle\_secret\_name](#input\_consul\_tls\_ca\_bundle\_secret\_name) | Name of AWS Secrets Manager secret for Consul TLS CA bundle. | `string` | `"consul-tls-ca-bundle-base64"` | no |
| <a name="input_consul_tls_ca_bundle_secret_value_base64"></a> [consul\_tls\_ca\_bundle\_secret\_value\_base64](#input\_consul\_tls\_ca\_bundle\_secret\_value\_base64) | Base64-encoded string value of Consul TLS CA bundle in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_consul_tls_cert_secret_name"></a> [consul\_tls\_cert\_secret\_name](#input\_consul\_tls\_cert\_secret\_name) | Name of AWS Secrets Manager secret for Consul TLS certificate. | `string` | `"consul-tls-cert-base64"` | no |
| <a name="input_consul_tls_cert_secret_value_base64"></a> [consul\_tls\_cert\_secret\_value\_base64](#input\_consul\_tls\_cert\_secret\_value\_base64) | Base64-encoded string value of Consul TLS certificate in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_consul_tls_privkey_secret_name"></a> [consul\_tls\_privkey\_secret\_name](#input\_consul\_tls\_privkey\_secret\_name) | Name of AWS Secrets Manager secret for Consul TLS private key. | `string` | `"consul-tls-privkey-base64"` | no |
| <a name="input_consul_tls_privkey_secret_value_base64"></a> [consul\_tls\_privkey\_secret\_value\_base64](#input\_consul\_tls\_privkey\_secret\_value\_base64) | Base64-encoded string value of Consul TLS private key in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_create_bastion"></a> [create\_bastion](#input\_create\_bastion) | Boolean to create a bastion EC2 instance. Only valid when `create_vpc` is `true`. | `bool` | `false` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Boolean to create a Cloud Watch Log Group to be used as a log forwarding destination. | `bool` | `false` | no |
| <a name="input_create_ec2_ssh_keypair"></a> [create\_ec2\_ssh\_keypair](#input\_create\_ec2\_ssh\_keypair) | Boolean to create EC2 SSH key pair. This is separate from the `bastion_keypair` input variable. | `bool` | `false` | no |
| <a name="input_create_kms_cmk"></a> [create\_kms\_cmk](#input\_create\_kms\_cmk) | Boolean to create AWS KMS customer managed key (CMK). | `bool` | `false` | no |
| <a name="input_create_snapshot_s3_bucket"></a> [create\_snapshot\_s3\_bucket](#input\_create\_snapshot\_s3\_bucket) | Boolean to S3 bucket for Consul snapshots. | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Boolean to create a VPC. | `bool` | `false` | no |
| <a name="input_ec2_ssh_keypair_name"></a> [ec2\_ssh\_keypair\_name](#input\_ec2\_ssh\_keypair\_name) | Name of EC2 SSH key pair. | `string` | `"ec2-keypair"` | no |
| <a name="input_ec2_ssh_public_key"></a> [ec2\_ssh\_public\_key](#input\_ec2\_ssh\_public\_key) | Public key material for EC2 SSH Key Pair. | `string` | `null` | no |
| <a name="input_encrypt_cloudwatch_log_group"></a> [encrypt\_cloudwatch\_log\_group](#input\_encrypt\_cloudwatch\_log\_group) | Boolean to encrypt CloudWatch Log Group with KMS key. Only valid when `create_kms_cmk` is `true`. | `bool` | `false` | no |
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | Friendly name prefix used for tagging and naming AWS resources. | `string` | n/a | yes |
| <a name="input_kms_allow_asg_to_cmk"></a> [kms\_allow\_asg\_to\_cmk](#input\_kms\_allow\_asg\_to\_cmk) | Boolen to create a KMS customer managed key (CMK) policy that grants the Service Linked Role 'AWSServiceRoleForAutoScaling' permissions to the CMK. | `bool` | `true` | no |
| <a name="input_kms_cmk_alias"></a> [kms\_cmk\_alias](#input\_kms\_cmk\_alias) | Alias for KMS customer managed key (CMK). | `string` | `null` | no |
| <a name="input_kms_cmk_deletion_window"></a> [kms\_cmk\_deletion\_window](#input\_kms\_cmk\_deletion\_window) | Duration in days to destroy the key after it is deleted. Must be between 7 and 30 days. | `number` | `7` | no |
| <a name="input_kms_cmk_enable_key_rotation"></a> [kms\_cmk\_enable\_key\_rotation](#input\_kms\_cmk\_enable\_key\_rotation) | Boolean to enable key rotation for the KMS customer managed key (CMK). | `bool` | `false` | no |
| <a name="input_lb_is_internal"></a> [lb\_is\_internal](#input\_lb\_is\_internal) | Boolean to create an internal (private) load balancer. | `bool` | `true` | no |
| <a name="input_log_group_retention_days"></a> [log\_group\_retention\_days](#input\_log\_group\_retention\_days) | Number of days to retain logs within CloudWatch Log Group. | `number` | `365` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of private subnet CIDR ranges to create in VPC. | `list(string)` | `[]` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of public subnet CIDR ranges to create in VPC. | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create resource in. | `string` | `null` | no |
| <a name="input_tfe_database_password_secret_name"></a> [tfe\_database\_password\_secret\_name](#input\_tfe\_database\_password\_secret\_name) | Name of AWS Secrets Manager secret for TFE database password. | `string` | `"tfe-database-password"` | no |
| <a name="input_tfe_database_password_secret_value"></a> [tfe\_database\_password\_secret\_value](#input\_tfe\_database\_password\_secret\_value) | Value of TFE Database Password create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_encryption_password_secret_name"></a> [tfe\_encryption\_password\_secret\_name](#input\_tfe\_encryption\_password\_secret\_name) | Name of AWS Secrets Manager secret for TFE encryption password. | `string` | `"tfe-encryption-password"` | no |
| <a name="input_tfe_encryption_password_secret_value"></a> [tfe\_encryption\_password\_secret\_value](#input\_tfe\_encryption\_password\_secret\_value) | Value of TFE Encryption Password to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_license_secret_name"></a> [tfe\_license\_secret\_name](#input\_tfe\_license\_secret\_name) | Name of AWS Secrets Manager secret for TFE license. | `string` | `"tfe-license"` | no |
| <a name="input_tfe_license_secret_value"></a> [tfe\_license\_secret\_value](#input\_tfe\_license\_secret\_value) | Raw contents of the TFE license file to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_redis_password_secret_name"></a> [tfe\_redis\_password\_secret\_name](#input\_tfe\_redis\_password\_secret\_name) | Name of AWS Secrets Manager secret for TFE Redis password. | `string` | `"tfe-redis-password"` | no |
| <a name="input_tfe_redis_password_secret_value"></a> [tfe\_redis\_password\_secret\_value](#input\_tfe\_redis\_password\_secret\_value) | Value of TFE Redis Password create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_tls_ca_bundle_secret_name"></a> [tfe\_tls\_ca\_bundle\_secret\_name](#input\_tfe\_tls\_ca\_bundle\_secret\_name) | Name of AWS Secrets Manager secret for TFE TLS CA bundle. | `string` | `"tfe-tls-ca-bundle-base64"` | no |
| <a name="input_tfe_tls_ca_bundle_secret_value_base64"></a> [tfe\_tls\_ca\_bundle\_secret\_value\_base64](#input\_tfe\_tls\_ca\_bundle\_secret\_value\_base64) | Base64-encoded string value of TFE TLS CA bundle in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_tls_cert_secret_name"></a> [tfe\_tls\_cert\_secret\_name](#input\_tfe\_tls\_cert\_secret\_name) | Name of AWS Secrets Manager secret for TFE TLS certificate. | `string` | `"tfe-tls-cert-base64"` | no |
| <a name="input_tfe_tls_cert_secret_value_base64"></a> [tfe\_tls\_cert\_secret\_value\_base64](#input\_tfe\_tls\_cert\_secret\_value\_base64) | Base64-encoded string value of TFE TLS certificate in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_tfe_tls_privkey_secret_name"></a> [tfe\_tls\_privkey\_secret\_name](#input\_tfe\_tls\_privkey\_secret\_name) | Name of AWS Secrets Manager secret for TFE TLS private key. | `string` | `"tfe-tls-privkey-base64"` | no |
| <a name="input_tfe_tls_privkey_secret_value_base64"></a> [tfe\_tls\_privkey\_secret\_value\_base64](#input\_tfe\_tls\_privkey\_secret\_value\_base64) | Base64-encoded string value of TFE TLS private key in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC. | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of VPC. | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_cert_arn"></a> [agent\_cert\_arn](#output\_agent\_cert\_arn) | n/a |
| <a name="output_agent_key_arn"></a> [agent\_key\_arn](#output\_agent\_key\_arn) | n/a |
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_ca_cert_arn"></a> [ca\_cert\_arn](#output\_ca\_cert\_arn) | n/a |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | ------------------------------------------------------------------------------ Logging ------------------------------------------------------------------------------ |
| <a name="output_license_text_arn"></a> [license\_text\_arn](#output\_license\_text\_arn) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | ------------------------------------------------------------------------------ S3 ------------------------------------------------------------------------------ |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ------------------------------------------------------------------------------ Networking ------------------------------------------------------------------------------ |
<!-- END_TF_DOCS -->
