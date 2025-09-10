terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.54.0"
    }
  }
}

provider "aws" {
  region = var.region 
}

module "prereqs" {
  source = "../.."

  # --- Common --- #
  friendly_name_prefix = var.friendly_name_prefix
  common_tags          = var.common_tags

  # --- Networking --- #
  create_vpc                     = var.create_vpc
  vpc_cidr                       = var.vpc_cidr
  public_subnet_cidrs            = var.public_subnet_cidrs
  private_subnet_cidrs           = var.private_subnet_cidrs
  create_bastion                 = var.create_bastion
  bastion_ec2_keypair_name       = var.bastion_ec2_keypair_name
  bastion_cidr_allow_ingress_ssh = var.bastion_cidr_allow_ingress_ssh

  # --- Secrets Manager Prereq Secrets --- #
  tfe_license_secret_value              = var.tfe_license_secret_value
  tfe_encryption_password_secret_value  = var.tfe_encryption_password_secret_value
  tfe_database_password_secret_value    = var.tfe_database_password_secret_value
  tfe_redis_password_secret_value       = var.tfe_redis_password_secret_value
  tfe_tls_cert_secret_value_base64      = var.tfe_tls_cert_secret_value_base64
  tfe_tls_privkey_secret_value_base64   = var.tfe_tls_privkey_secret_value_base64
  tfe_tls_ca_bundle_secret_value_base64 = var.tfe_tls_ca_bundle_secret_value_base64

  # --- Cloudwatch Log Group --- #
  create_cloudwatch_log_group = var.create_cloudwatch_log_group

  # --- KMS --- #
  create_kms_cmk              = var.create_kms_cmk
  kms_cmk_alias               = var.kms_cmk_alias
  kms_allow_asg_to_cmk        = var.kms_allow_asg_to_cmk
  kms_cmk_deletion_window     = var.kms_cmk_deletion_window
  kms_cmk_enable_key_rotation = var.kms_cmk_enable_key_rotation
}

