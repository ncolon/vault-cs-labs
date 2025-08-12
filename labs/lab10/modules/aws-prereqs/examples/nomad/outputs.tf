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
  value = module.prereqs.private_subnet_ids
}

output "lb_is_internal" {
  value = module.prereqs.private_subnet_ids
}

output "ec2_subnet_ids" {
  value = module.prereqs.private_subnet_ids
}

output "bastion_public_ip" {
  value = module.prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "nomad_license_secret_arn" {
  value = module.prereqs.nomad_license_secret_arn
}

output "nomad_gossip_encryption_key_secret_arn" {
  value = module.prereqs.nomad_gossip_encryption_key_secret_arn
}

output "nomad_tls_cert_secret_arn" {
  value = module.prereqs.nomad_tls_cert_secret_arn
}

output "nomad_tls_privkey_secret_arn" {
  value = module.prereqs.nomad_tls_privkey_secret_arn
}

output "nomad_tls_ca_bundle_secret_arn" {
  value = module.prereqs.nomad_tls_ca_bundle_secret_arn
}
