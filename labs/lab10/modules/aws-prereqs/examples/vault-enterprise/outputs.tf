#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
output "net_vpc_id" {
  value = module.prereqs.vpc_id
}

output "public_subnet_ids" {
  value = module.prereqs.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "net_lb_subnet_ids" {
  value = var.lb_is_internal ? module.prereqs.private_subnet_ids : module.prereqs.public_subnet_ids
}

output "net_vault_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "bastion_public_ip" {
  value = module.prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "sm_vault_license_arn" {
  value = module.prereqs.vault_license_secret_arn
}

output "sm_vault_tls_cert_arn" {
  value = module.prereqs.vault_tls_cert_secret_arn
}

output "sm_vault_tls_cert_key_arn" {
  value = module.prereqs.vault_tls_privkey_secret_arn
}

output "sm_vault_tls_ca_bundle" {
  value = module.prereqs.vault_tls_ca_bundle_secret_arn
}
#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------
output "vault_seal_awskms_key_arn" {
  value = module.prereqs.kms_cmk_arn

}
