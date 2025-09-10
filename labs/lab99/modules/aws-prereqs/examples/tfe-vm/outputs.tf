#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
output "vpc_id" {
  value = module.prereqs.vpc_id
}

output "public_subnet_ids" {
  value = module.prereqs.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "lb_subnet_ids" {
  value = var.lb_is_internal ? module.prereqs.private_subnet_ids : module.prereqs.public_subnet_ids
}

output "lb_is_internal" {
  value = var.lb_is_internal
}

output "ec2_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "rds_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "redis_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "bastion_public_ip" {
  value = module.prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "tfe_license_secret_arn" {
  value = module.prereqs.tfe_license_secret_arn
}

output "tfe_encryption_password_secret_arn" {
  value = module.prereqs.tfe_encryption_password_secret_arn
}

output "tfe_database_password_secret_arn" {
  value = module.prereqs.tfe_database_password_secret_arn
}

output "tfe_redis_password_secret_arn" {
  value = module.prereqs.tfe_redis_password_secret_arn
}

output "tfe_tls_cert_secret_arn" {
  value = module.prereqs.tfe_tls_cert_secret_arn
}

output "tfe_tls_privkey_secret_arn" {
  value = module.prereqs.tfe_tls_privkey_secret_arn
}

output "tfe_tls_ca_bundle_secret_arn" {
  value = module.prereqs.tfe_tls_ca_bundle_secret_arn
}

#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------
output "cloudwatch_log_group_name" {
  value = module.prereqs.cloudwatch_log_group_name
}
