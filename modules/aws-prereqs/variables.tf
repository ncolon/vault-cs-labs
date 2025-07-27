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
  default     = null
}

#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
variable "create_vpc" {
  type        = bool
  description = "Boolean to create a VPC."
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
  default     = "10.1.0.0/16"
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
# TFE Secrets Manager
#------------------------------------------------------------------------------
variable "tfe_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE license."
  default     = "tfe-license"
}

variable "tfe_license_secret_value" {
  type        = string
  description = "Raw contents of the TFE license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_encryption_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE encryption password."
  default     = "tfe-encryption-password"
}

variable "tfe_encryption_password_secret_value" {
  type        = string
  description = "Value of TFE Encryption Password to create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_database_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE database password."
  default     = "tfe-database-password"
}

variable "tfe_database_password_secret_value" {
  type        = string
  description = "Value of TFE Database Password create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_redis_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE Redis password."
  default     = "tfe-redis-password"
}

variable "tfe_redis_password_secret_value" {
  type        = string
  description = "Value of TFE Redis Password create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE TLS certificate."
  default     = "tfe-tls-cert-base64"
}

variable "tfe_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of TFE TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE TLS private key."
  default     = "tfe-tls-privkey-base64"
}

variable "tfe_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of TFE TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "tfe_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for TFE TLS CA bundle."
  default     = "tfe-tls-ca-bundle-base64"
}

variable "tfe_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of TFE TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

#------------------------------------------------------------------------------
# Boundary Secrets Manager
#------------------------------------------------------------------------------
variable "boundary_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Boundary license."
  default     = "boundary-license"
}

variable "boundary_license_secret_value" {
  type        = string
  description = "Raw contents of the Boundary license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "boundary_database_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Boundary database password."
  default     = "boundary-database-password"
}

variable "boundary_database_password_secret_value" {
  type        = string
  description = "Value of Boundary Database Password create as AWS Secrets Manager secret."
  default     = null
}

variable "boundary_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Boundary TLS certificate."
  default     = "boundary-tls-cert-base64"
}

variable "boundary_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Boundary TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "boundary_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Boundary TLS private key."
  default     = "boundary-tls-privkey-base64"
}

variable "boundary_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Boundary TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "boundary_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Boundary TLS CA bundle."
  default     = "boundary-tls-ca-bundle-base64"
}

variable "boundary_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Boundary TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

#------------------------------------------------------------------------------
# Nomad Secrets Manager
#------------------------------------------------------------------------------
variable "nomad_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Nomad license."
  default     = "nomad-license"
}

variable "nomad_license_secret_value" {
  type        = string
  description = "Raw contents of the Nomad license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "nomad_gossip_encryption_key_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Nomad gossip encryption key."
  default     = "nomad-gossip"
}

variable "nomad_gossip_encryption_key_secret_value" {
  type        = string
  description = "Value of Nomad Gossip Encryption key to create as AWS Secrets Manager secret"
  default     = null
}

variable "nomad_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Nomad TLS certificate."
  default     = "nomad-tls-cert-base64"
}

variable "nomad_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Nomad TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "nomad_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Nomad TLS private key."
  default     = "nomad-tls-privkey-base64"
}

variable "nomad_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Nomad TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "nomad_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Nomad TLS CA bundle."
  default     = "nomad-tls-ca-bundle-base64"
}

variable "nomad_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Nomad TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
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

#------------------------------------------------------------------------------
# CloudWatch "Logging" Log Group
#------------------------------------------------------------------------------
variable "create_cloudwatch_log_group" {
  type        = bool
  description = "Boolean to create a Cloud Watch Log Group to be used as a log forwarding destination."
  default     = false
}

variable "cloudwatch_log_group_name" {
  type        = string
  description = "Name of CloudWatch Log Group for log forwarding destination."
  default     = "log-group"
}

variable "encrypt_cloudwatch_log_group" {
  type        = bool
  description = "Boolean to encrypt CloudWatch Log Group with KMS key. Only valid when `create_kms_cmk` is `true`."
  default     = false
}

variable "log_group_retention_days" {
  type        = number
  description = "Number of days to retain logs within CloudWatch Log Group."
  default     = 365

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 180, 365, 400, 545, 731, 1827, 3653], var.log_group_retention_days)
    error_message = "Supported values are `1`, `3`, `5`, `7`, `14`, `30`, `60`, `90`, `120`, `150`, `180`, `365`, `400`, `545`, `731`, `1827`, `3653`."
  }
}

#------------------------------------------------------------------------------
# S3 bucket
#------------------------------------------------------------------------------
variable "create_snapshot_s3_bucket" {
  type        = bool
  description = "Boolean to S3 bucket for Consul snapshots."
  default     = false
}

#------------------------------------------------------------------------------
# Consul Secrets Manager
#------------------------------------------------------------------------------
variable "consul_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Consul license."
  default     = "consul-license"
}

variable "consul_license_secret_value" {
  type        = string
  description = "Raw contents of the Consul license file to create as AWS Secrets Manager secret."
  default     = null
}


variable "consul_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Consul TLS certificate."
  default     = "consul-tls-cert-base64"
}

variable "consul_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Consul TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "consul_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Consul TLS private key."
  default     = "consul-tls-privkey-base64"
}

variable "consul_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Consul TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "consul_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for Consul TLS CA bundle."
  default     = "consul-tls-ca-bundle-base64"
}

variable "consul_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of Consul TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

#------------------------------------------------------------------------------
# VAULT Secrets Manager
#------------------------------------------------------------------------------
variable "vault_license_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for VAULT license."
  default     = "vault-license"
}

variable "vault_license_secret_value" {
  type        = string
  description = "Raw contents of the VAULT license file to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_encryption_password_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for VAULT encryption password."
  default     = "vault-encryption-password"
}

variable "vault_encryption_password_secret_value" {
  type        = string
  description = "Value of VAULT Encryption Password to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_cert_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for VAULT TLS certificate."
  default     = "vault-tls-cert-base64"
}

variable "vault_tls_cert_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of VAULT TLS certificate in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_privkey_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for VAULT TLS private key."
  default     = "vault-tls-privkey-base64"
}

variable "vault_tls_privkey_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of VAULT TLS private key in PEM format to create as AWS Secrets Manager secret."
  default     = null
}

variable "vault_tls_ca_bundle_secret_name" {
  type        = string
  description = "Name of AWS Secrets Manager secret for VAULT TLS CA bundle."
  default     = "vault-tls-ca-bundle-base64"
}

variable "vault_tls_ca_bundle_secret_value_base64" {
  type        = string
  description = "Base64-encoded string value of VAULT TLS CA bundle in PEM format to create as AWS Secrets Manager secret."
  default     = null
}
