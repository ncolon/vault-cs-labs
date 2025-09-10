#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
output "vpc_id" {
  value = module.prereqs.vpc_id
}

output "api_lb_is_internal" {
  value = var.api_lb_is_internal
}

output "api_lb_subnet_ids" {
  value = var.api_lb_is_internal ? module.prereqs.private_subnet_ids : module.prereqs.public_subnet_ids
}

output "cluster_lb_subnet_ids" {
  value = var.api_lb_is_internal ? module.prereqs.private_subnet_ids : module.prereqs.public_subnet_ids
}

output "controller_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "rds_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.prereqs.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "bastion_public_ip" {
  value = module.prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "boundary_license_secret_arn" {
  value = module.prereqs.boundary_license_secret_arn
}

output "boundary_database_password_secret_arn" {
  value = module.prereqs.boundary_database_password_secret_arn
}

output "boundary_tls_cert_secret_arn" {
  value = module.prereqs.boundary_tls_cert_secret_arn
}

output "boundary_tls_privkey_secret_arn" {
  value = module.prereqs.boundary_tls_privkey_secret_arn
}

output "boundary_tls_ca_bundle_secret_arn" {
  value = module.prereqs.boundary_tls_ca_bundle_secret_arn
}
