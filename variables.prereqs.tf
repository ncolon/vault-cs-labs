#------------------------------------------------------------------------------
# Common
#------------------------------------------------------------------------------
variable "friendly_name_prefix" {
  type        = string
  description = "Friendly name prefix used for tagging and naming AWS resources."
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for all taggable AWS resources."
  default     = {}
}

variable "region" {
  type        = string
  description = "AWS region to create resource in."
}

#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
variable "create_vpc" {
  type        = bool
  description = "Boolean to create a VPC."
  default     = false
}
variable "create_nat_gateway" {
  type        = bool
  description = "Boolean to create a NAT Gateway."
  default     = false
}

variable "vpc_name" {
  type        = string
  description = "Name of VPC."
  default     = "vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC."
  default     = null
}

variable "lb_is_internal" {
  type        = bool
  description = "Boolean to create an internal (private) load balancer."
  default     = true
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDR ranges to create in VPC."
  default     = []
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDR ranges to create in VPC."
  default     = []
}

variable "create_bastion" {
  type        = bool
  description = "Boolean to create a bastion EC2 instance. Only valid when `create_vpc` is `true`."
  default     = false
}

variable "bastion_ec2_keypair_name" {
  type        = string
  description = "Existing SSH key pair to use for bastion EC2 instance."
  default     = null
}

variable "bastion_cidr_allow_ingress_ssh" {
  type        = list(string)
  description = "List of source CIDR ranges to allow inbound to bastion on port 22 (SSH)."
  default     = []
}

#------------------------------------------------------------------------------
# Vault Secrets Manager
#------------------------------------------------------------------------------
variable "vault_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault license."
  default     = "vault-license"
}

variable "vault_license_secret_value" {
  type        = string
  description = "Raw contents of the vault license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_encryption_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault encryption password."
  default     = "vault-encryption-password"
}

variable "vault_encryption_password_secret_value" {
  type        = string
  description = "Value of vault Encryption Password to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_database_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault database password."
  default     = "vault-database-password"
}

variable "vault_database_password_secret_value" {
  type        = string
  description = "Value of vault Database Password create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_redis_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault Redis password."
  default     = "vault-redis-password"
}

variable "vault_redis_password_secret_value" {
  type        = string
  description = "Value of vault Redis Password create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS certificate."
  default     = "vault-tls-cert-base64"
}

variable "vault_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS private key."
  default     = "vault-tls-privkey-base64"
}

variable "vault_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for vault TLS CA bundle."
  default     = "vault-tls-ca-bundle-base64"
}

variable "vault_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of vault TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------
variable "create_kms_cmk" {
  type        = bool
  description = "Boolean to create AWS KMS customer managed key (CMK)."
  default     = false
}

variable "kms_cmk_alias" {
  type        = string
  description = "Alias for KMS customer managed key (CMK)."
  default     = null
}

variable "kms_cmk_deletion_window" {
  type        = number
  description = "Duration in days to destroy the key after it is deleted. Must be between 7 and 30 days."
  default     = 7
}

variable "kms_cmk_enable_key_rotation" {
  type        = bool
  description = "Boolean to enable key rotation for the KMS customer managed key (CMK)."
  default     = false
}

variable "kms_allow_asg_to_cmk" {
  type        = bool
  description = "Boolen to create a KMS customer managed key (CMK) policy that grants the Service Linked Role 'AWSServiceRoleForAutoScaling' permissions to the CMK."
  default     = true
}

#------------------------------------------------------------------------------
# EC2 SSH Key Pairs
#------------------------------------------------------------------------------
variable "create_ec2_ssh_keypair" {
  type        = bool
  description = "Boolean to create EC2 SSH key pair. This is separate from the `bastion_keypair` input variable."
  default     = false
}

variable "ec2_ssh_keypair_name" {
  type        = string
  description = "Name of EC2 SSH key pair."
  default     = "ec2-keypair"
}

variable "ec2_ssh_public_key" {
  type        = string
  description = "Public key material for EC2 SSH Key Pair."
  default     = null
}
