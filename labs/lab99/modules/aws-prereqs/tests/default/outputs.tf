#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
output "vpc_id" {
  value = module.tfe_prereqs.vpc_id
}

output "public_subnet_ids" {
  value = module.tfe_prereqs.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.tfe_prereqs.private_subnet_ids
}

output "bastion_public_ip" {
  value = module.tfe_prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "tfe_license_secret_arn" {
  value = module.tfe_prereqs.tfe_license_secret_arn
}

output "tfe_encryption_password_secret_arn" {
  value = module.tfe_prereqs.tfe_encryption_password_secret_arn
}

output "tfe_database_password_secret_arn" {
  value = module.tfe_prereqs.tfe_database_password_secret_arn
}

output "tfe_redis_password_secret_arn" {
  value = module.tfe_prereqs.tfe_redis_password_secret_arn
}

output "tfe_tls_cert_secret_arn" {
  value = module.tfe_prereqs.tfe_tls_cert_secret_arn
}

output "tfe_tls_privkey_secret_arn" {
  value = module.tfe_prereqs.tfe_tls_privkey_secret_arn
}

output "tfe_tls_ca_bundle_secret_arn" {
  value = module.tfe_prereqs.tfe_tls_ca_bundle_secret_arn
}

#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------
output "cloudwatch_log_group_name" {
  value = module.tfe_prereqs.cloudwatch_log_group_name
}
