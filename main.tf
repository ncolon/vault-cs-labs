provider "aws" {
  region = var.region
}

module "tls" {
  source = "./modules/tls"
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

locals {
  random_prefix = "${var.friendly_name_prefix}-${random_string.random.result}"
  merged_tags = merge(
    var.common_tags,
    { Instance = local.random_prefix }
  )
}

module "prereqs" {
  source = "./modules/aws-prereqs"

  # --- Common --- #
  friendly_name_prefix = local.random_prefix
  common_tags          = local.merged_tags

  # --- Networking --- #
  create_vpc                     = var.create_vpc
  vpc_cidr                       = var.vpc_cidr
  public_subnet_cidrs            = var.public_subnet_cidrs
  private_subnet_cidrs           = var.private_subnet_cidrs
  create_bastion                 = var.create_bastion
  bastion_ec2_keypair_name       = var.bastion_ec2_keypair_name
  bastion_cidr_allow_ingress_ssh = var.bastion_cidr_allow_ingress_ssh
  create_ec2_ssh_keypair         = var.create_ec2_ssh_keypair
  ec2_ssh_keypair_name           = var.ec2_ssh_keypair_name


  # --- Secrets Manager Prereq Secrets --- #
  vault_license_secret_value = file("vault.hclic")
  #vault_encryption_password_secret_value  = var.vault_encryption_password_secret_value
  vault_tls_cert_secret_value_base64      = module.tls.tls_cert_content_base64
  vault_tls_privkey_secret_value_base64   = module.tls.tls_key_content_base64
  vault_tls_ca_bundle_secret_value_base64 = module.tls.ca_cert_content_base64

  # --- KMS --- #
  create_kms_cmk              = var.create_kms_cmk
  kms_cmk_alias               = var.kms_cmk_alias
  kms_allow_asg_to_cmk        = var.kms_allow_asg_to_cmk
  kms_cmk_deletion_window     = var.kms_cmk_deletion_window
  kms_cmk_enable_key_rotation = var.kms_cmk_enable_key_rotation
}

module "vault" {
  source = "github.com/hashicorp/terraform-aws-vault-enterprise-hvd?ref=0.2.0"

  #------------------------------------------------------------------------------
  # Common
  #------------------------------------------------------------------------------
  friendly_name_prefix = local.random_prefix
  vault_fqdn           = var.vault_fqdn

  #------------------------------------------------------------------------------
  # Networking
  #------------------------------------------------------------------------------
  net_vpc_id                    = module.prereqs.vpc_id
  load_balancing_scheme         = var.load_balancing_scheme
  net_vault_subnet_ids          = module.prereqs.private_subnet_ids
  net_lb_subnet_ids             = module.prereqs.public_subnet_ids
  net_ingress_vault_cidr_blocks = var.net_ingress_vault_cidr_blocks
  net_ingress_ssh_cidr_blocks   = var.net_ingress_ssh_cidr_blocks

  #------------------------------------------------------------------------------
  # AWS Secrets Manager installation secrets and AWS KMS unseal key
  #------------------------------------------------------------------------------
  sm_vault_license_arn              = module.prereqs.vault_license_secret_arn
  sm_vault_tls_cert_arn             = module.prereqs.vault_tls_cert_secret_arn
  sm_vault_tls_cert_key_arn         = module.prereqs.vault_tls_privkey_secret_arn
  sm_vault_tls_ca_bundle            = module.prereqs.vault_tls_ca_bundle_secret_arn
  vault_seal_awskms_key_arn         = module.prereqs.kms_cmk_arn
  vault_raft_performance_multiplier = var.vault_raft_performance_multiplier
  vault_version                     = var.vault_version

  #------------------------------------------------------------------------------
  # Compute
  #------------------------------------------------------------------------------
  vm_key_pair_name = var.vm_key_pair_name
  vm_instance_type = "t3a.medium"
  asg_node_count   = 3
}
