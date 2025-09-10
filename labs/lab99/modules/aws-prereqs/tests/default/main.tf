#------------------------------------------------------------------------------
# Versions
#------------------------------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }
  }
}

#------------------------------------------------------------------------------
# Providers
#------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

#------------------------------------------------------------------------------
# Test Fixtures
#------------------------------------------------------------------------------
resource "random_bytes" "suffix" {
  length = 4
}

#------------------------------------------------------------------------------
# Module
#------------------------------------------------------------------------------
module "tfe_prereqs" {
  source = "../.."

  # --- Common --- #
  friendly_name_prefix = "ps-ci-test"
  common_tags = {
    App         = "tfe-prereqs"
    Environment = "sandbox"
    Module      = "terraform-aws-tfe-prereqs"
    Scenario    = "default"
    Owner       = "ps-ci-test"
  }

  # --- Networking --- #
  create_vpc                     = true
  vpc_cidr                       = "10.0.0.0/16"
  public_subnet_cidrs            = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs           = ["10.0.255.0/24", "10.0.254.0/24", "10.0.253.0/24"]
  create_bastion                 = true
  bastion_ec2_keypair_name       = "ps-ci-test-keypair-east1"
  bastion_cidr_allow_ingress_ssh = ["0.0.0.0/0"]

  # --- Secrets Manager Prereq Secrets --- #
  tfe_license_secret_name               = "tfe-license-${random_bytes.suffix.hex}"
  tfe_license_secret_value              = "iamafaketfelicensekey"
  tfe_encryption_password_secret_name   = "tfe-encryption-password-${random_bytes.suffix.hex}"
  tfe_encryption_password_secret_value  = "iamafaketfeencryptionpassword"
  tfe_database_password_secret_name     = "tfe-database-password-${random_bytes.suffix.hex}"
  tfe_database_password_secret_value    = "iamafaketfedatabasepassword"
  tfe_redis_password_secret_name        = "tfe-database-redis-${random_bytes.suffix.hex}"
  tfe_redis_password_secret_value       = "iamafaketferedispassword"
  tfe_tls_cert_secret_name              = "tfe-tls-cert-${random_bytes.suffix.hex}"
  tfe_tls_cert_secret_value_base64      = "iamafaketfetlscertpemthatisbase64encoded"
  tfe_tls_privkey_secret_name           = "tfe-tls-privkey-${random_bytes.suffix.hex}"
  tfe_tls_privkey_secret_value_base64   = "iamafaketfetlsprivkeypemthatisbase64encoded"
  tfe_tls_ca_bundle_secret_name         = "tfe-tls-ca-bundle-${random_bytes.suffix.hex}"
  tfe_tls_ca_bundle_secret_value_base64 = "iamafaketfetlscabundlepemthatisbase64encoded"

  # --- KMS --- #
  create_kms_cmk = true
  kms_cmk_alias  = "tfe-kms-cmk-test-${random_bytes.suffix.hex}"

  # --- Cloudwatch Log Group --- #
  create_cloudwatch_log_group = true
  cloudwatch_log_group_name   = "tfe-prereqs-test-${random_bytes.suffix.hex}"
}