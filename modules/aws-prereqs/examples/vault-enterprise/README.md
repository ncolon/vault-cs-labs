# Vault Enterprise Example

This module is an example of utilizing this module as part of the HashiCorp Validated Design prerequisite Solution Design Guide. Users can use this to deploy prerequisite infrastructure required to install Vault Enterprise into AWS.

After having all resources deployed, you can use the following module [terraform-aws-vault-enterprise-hvd](https://github.com/hashicorp/terraform-aws-vault-enterprise-hvd) to continue installing Vault as described in HashiCorp Validated Design.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.54.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_prereqs"></a> [prereqs](#module\_prereqs) | ../.. | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | Friendly name prefix used for tagging and naming AWS resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to create resource in. | `string` | n/a | yes |
| <a name="input_bastion_cidr_allow_ingress_ssh"></a> [bastion\_cidr\_allow\_ingress\_ssh](#input\_bastion\_cidr\_allow\_ingress\_ssh) | List of source CIDR ranges to allow inbound to bastion on port 22 (SSH). | `list(string)` | `[]` | no |
| <a name="input_bastion_ec2_keypair_name"></a> [bastion\_ec2\_keypair\_name](#input\_bastion\_ec2\_keypair\_name) | Existing SSH key pair to use for bastion EC2 instance. | `string` | `null` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_create_bastion"></a> [create\_bastion](#input\_create\_bastion) | Boolean to create a bastion EC2 instance. Only valid when `create_vpc` is `true`. | `bool` | `false` | no |
| <a name="input_create_ec2_ssh_keypair"></a> [create\_ec2\_ssh\_keypair](#input\_create\_ec2\_ssh\_keypair) | Boolean to create EC2 SSH key pair. This is separate from the `bastion_keypair` input variable. | `bool` | `false` | no |
| <a name="input_create_kms_cmk"></a> [create\_kms\_cmk](#input\_create\_kms\_cmk) | Boolean to create AWS KMS customer managed key (CMK). | `bool` | `false` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Boolean to create a NAT Gateway. | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Boolean to create a VPC. | `bool` | `false` | no |
| <a name="input_ec2_ssh_keypair_name"></a> [ec2\_ssh\_keypair\_name](#input\_ec2\_ssh\_keypair\_name) | Name of EC2 SSH key pair. | `string` | `"ec2-keypair"` | no |
| <a name="input_ec2_ssh_public_key"></a> [ec2\_ssh\_public\_key](#input\_ec2\_ssh\_public\_key) | Public key material for EC2 SSH Key Pair. | `string` | `null` | no |
| <a name="input_kms_allow_asg_to_cmk"></a> [kms\_allow\_asg\_to\_cmk](#input\_kms\_allow\_asg\_to\_cmk) | Boolen to create a KMS customer managed key (CMK) policy that grants the Service Linked Role 'AWSServiceRoleForAutoScaling' permissions to the CMK. | `bool` | `true` | no |
| <a name="input_kms_cmk_alias"></a> [kms\_cmk\_alias](#input\_kms\_cmk\_alias) | Alias for KMS customer managed key (CMK). | `string` | `null` | no |
| <a name="input_kms_cmk_deletion_window"></a> [kms\_cmk\_deletion\_window](#input\_kms\_cmk\_deletion\_window) | Duration in days to destroy the key after it is deleted. Must be between 7 and 30 days. | `number` | `7` | no |
| <a name="input_kms_cmk_enable_key_rotation"></a> [kms\_cmk\_enable\_key\_rotation](#input\_kms\_cmk\_enable\_key\_rotation) | Boolean to enable key rotation for the KMS customer managed key (CMK). | `bool` | `false` | no |
| <a name="input_lb_is_internal"></a> [lb\_is\_internal](#input\_lb\_is\_internal) | Boolean to create an internal (private) load balancer. | `bool` | `true` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of private subnet CIDR ranges to create in VPC. | `list(string)` | `[]` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of public subnet CIDR ranges to create in VPC. | `list(string)` | `[]` | no |
| <a name="input_vault_database_password_secret_name"></a> [vault\_database\_password\_secret\_name](#input\_vault\_database\_password\_secret\_name) | Name of AWS Secrets Manager secret for vault database password. | `string` | `"vault-database-password"` | no |
| <a name="input_vault_database_password_secret_value"></a> [vault\_database\_password\_secret\_value](#input\_vault\_database\_password\_secret\_value) | Value of vault Database Password create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_encryption_password_secret_name"></a> [vault\_encryption\_password\_secret\_name](#input\_vault\_encryption\_password\_secret\_name) | Name of AWS Secrets Manager secret for vault encryption password. | `string` | `"vault-encryption-password"` | no |
| <a name="input_vault_encryption_password_secret_value"></a> [vault\_encryption\_password\_secret\_value](#input\_vault\_encryption\_password\_secret\_value) | Value of vault Encryption Password to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_license_secret_name"></a> [vault\_license\_secret\_name](#input\_vault\_license\_secret\_name) | Name of AWS Secrets Manager secret for vault license. | `string` | `"vault-license"` | no |
| <a name="input_vault_license_secret_value"></a> [vault\_license\_secret\_value](#input\_vault\_license\_secret\_value) | Raw contents of the vault license file to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_redis_password_secret_name"></a> [vault\_redis\_password\_secret\_name](#input\_vault\_redis\_password\_secret\_name) | Name of AWS Secrets Manager secret for vault Redis password. | `string` | `"vault-redis-password"` | no |
| <a name="input_vault_redis_password_secret_value"></a> [vault\_redis\_password\_secret\_value](#input\_vault\_redis\_password\_secret\_value) | Value of vault Redis Password create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_tls_ca_bundle_secret_name"></a> [vault\_tls\_ca\_bundle\_secret\_name](#input\_vault\_tls\_ca\_bundle\_secret\_name) | Name of AWS Secrets Manager secret for vault TLS CA bundle. | `string` | `"vault-tls-ca-bundle-base64"` | no |
| <a name="input_vault_tls_ca_bundle_secret_value_base64"></a> [vault\_tls\_ca\_bundle\_secret\_value\_base64](#input\_vault\_tls\_ca\_bundle\_secret\_value\_base64) | Base64-encoded string value of vault TLS CA bundle in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_tls_cert_secret_name"></a> [vault\_tls\_cert\_secret\_name](#input\_vault\_tls\_cert\_secret\_name) | Name of AWS Secrets Manager secret for vault TLS certificate. | `string` | `"vault-tls-cert-base64"` | no |
| <a name="input_vault_tls_cert_secret_value_base64"></a> [vault\_tls\_cert\_secret\_value\_base64](#input\_vault\_tls\_cert\_secret\_value\_base64) | Base64-encoded string value of vault TLS certificate in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vault_tls_privkey_secret_name"></a> [vault\_tls\_privkey\_secret\_name](#input\_vault\_tls\_privkey\_secret\_name) | Name of AWS Secrets Manager secret for vault TLS private key. | `string` | `"vault-tls-privkey-base64"` | no |
| <a name="input_vault_tls_privkey_secret_value_base64"></a> [vault\_tls\_privkey\_secret\_value\_base64](#input\_vault\_tls\_privkey\_secret\_value\_base64) | Base64-encoded string value of vault TLS private key in PEM format to create as AWS Secrets Manager secret. | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC. | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of VPC. | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_ec2_subnet_ids"></a> [ec2\_subnet\_ids](#output\_ec2\_subnet\_ids) | n/a |
| <a name="output_kms_cmk_arn"></a> [kms\_cmk\_arn](#output\_kms\_cmk\_arn) | ------------------------------------------------------------------------------ KMS ------------------------------------------------------------------------------ |
| <a name="output_lb_is_internal"></a> [lb\_is\_internal](#output\_lb\_is\_internal) | n/a |
| <a name="output_lb_subnet_ids"></a> [lb\_subnet\_ids](#output\_lb\_subnet\_ids) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vault_encryption_password_secret_arn"></a> [vault\_encryption\_password\_secret\_arn](#output\_vault\_encryption\_password\_secret\_arn) | n/a |
| <a name="output_vault_license_secret_arn"></a> [vault\_license\_secret\_arn](#output\_vault\_license\_secret\_arn) | ------------------------------------------------------------------------------ Secrets Manager ------------------------------------------------------------------------------ |
| <a name="output_vault_tls_ca_bundle_secret_arn"></a> [vault\_tls\_ca\_bundle\_secret\_arn](#output\_vault\_tls\_ca\_bundle\_secret\_arn) | n/a |
| <a name="output_vault_tls_cert_secret_arn"></a> [vault\_tls\_cert\_secret\_arn](#output\_vault\_tls\_cert\_secret\_arn) | n/a |
| <a name="output_vault_tls_privkey_secret_arn"></a> [vault\_tls\_privkey\_secret\_arn](#output\_vault\_tls\_privkey\_secret\_arn) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ------------------------------------------------------------------------------ Networking ------------------------------------------------------------------------------ |
<!-- END_TF_DOCS -->
