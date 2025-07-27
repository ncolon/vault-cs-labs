#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
output "vpc_id" {
  value       = try(aws_vpc.main[0].id, null)
  description = "VPC ID."
}

output "private_subnet_ids" {
  value       = try(aws_subnet.private.*.id, null)
  description = "Subnet IDs of private subnets."
}

output "public_subnet_ids" {
  value       = try(aws_subnet.public.*.id, null)
  description = "Subnet IDs of public subnets."
}

output "bastion_public_dns" {
  value       = try(aws_instance.bastion[0].public_dns, null)
  description = "Public DNS name of bastion EC2 instance."
}

output "bastion_public_ip" {
  value       = try(aws_instance.bastion[0].public_ip, null)
  description = "Public IP of bastion EC2 instance."
}

output "bastion_private_ip" {
  value       = try(aws_instance.bastion[0].private_ip, null)
  description = "Private IP of bastion EC2 instance."
}

#------------------------------------------------------------------------------
# TFE Secrets Manager
#------------------------------------------------------------------------------
output "tfe_license_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_license[0].arn, null)
  description = "ARN of TFE license AWS Secrets Manager secret."
}

output "tfe_encryption_password_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_encryption_password[0].arn, null)
  description = "ARN of TFE encryption password AWS Secrets Manager secret."
}

output "tfe_database_password_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_database_password[0].arn, null)
  description = "ARN of TFE database password AWS Secrets Manager secret."
}

output "tfe_redis_password_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_redis_password[0].arn, null)
  description = "ARN of TFE Redis password AWS Secrets Manager secret."
}

output "tfe_tls_cert_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_tls_cert[0].arn, null)
  description = "ARN of TFE TLS certificate AWS Secrets Manager secret."
}

output "tfe_tls_privkey_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_tls_privkey[0].arn, null)
  description = "ARN of TFE TLS private key AWS Secrets Manager secret."
}

output "tfe_tls_ca_bundle_secret_arn" {
  value       = try(aws_secretsmanager_secret.tfe_tls_ca_bundle[0].arn, null)
  description = "ARN of TFE TLS CA bundle AWS Secrets Manager secret."
}

#------------------------------------------------------------------------------
# Nomad Secrets Manager
#------------------------------------------------------------------------------
output "nomad_license_secret_arn" {
  value       = try(aws_secretsmanager_secret.nomad_license[0].arn, null)
  description = "ARN of Nomad license AWS Secrets Manager secret."
}

output "nomad_gossip_encryption_key_secret_arn" {
  value       = try(aws_secretsmanager_secret.nomad_gossip_encryption_key[0].arn, null)
  description = "ARN of Nomad gossip encryption key AWS Secrets Manager secret."
}

output "nomad_tls_cert_secret_arn" {
  value       = try(aws_secretsmanager_secret.nomad_tls_cert[0].arn, null)
  description = "ARN of Nomad TLS certificate AWS Secrets Manager secret."
}

output "nomad_tls_privkey_secret_arn" {
  value       = try(aws_secretsmanager_secret.nomad_tls_privkey[0].arn, null)
  description = "ARN of Nomad TLS private key AWS Secrets Manager secret."
}

output "nomad_tls_ca_bundle_secret_arn" {
  value       = try(aws_secretsmanager_secret.nomad_tls_ca_bundle[0].arn, null)
  description = "ARN of Nomad TLS CA bundle AWS Secrets Manager secret."
}

#------------------------------------------------------------------------------
# Boundary Secrets Manager
#------------------------------------------------------------------------------
output "boundary_license_secret_arn" {
  value       = try(aws_secretsmanager_secret.boundary_license[0].arn, null)
  description = "ARN of Boundary license AWS Secrets Manager secret."
}

output "boundary_database_password_secret_arn" {
  value       = try(aws_secretsmanager_secret.boundary_database_password[0].arn, null)
  description = "ARN of Boundary database password AWS Secrets Manager secret."
}

output "boundary_tls_cert_secret_arn" {
  value       = try(aws_secretsmanager_secret.boundary_tls_cert[0].arn, null)
  description = "ARN of Boundary TLS certificate AWS Secrets Manager secret."
}

output "boundary_tls_privkey_secret_arn" {
  value       = try(aws_secretsmanager_secret.boundary_tls_privkey[0].arn, null)
  description = "ARN of Boundary TLS private key AWS Secrets Manager secret."
}

output "boundary_tls_ca_bundle_secret_arn" {
  value       = try(aws_secretsmanager_secret.boundary_tls_ca_bundle[0].arn, null)
  description = "ARN of Boundary TLS CA bundle AWS Secrets Manager secret."
}

#------------------------------------------------------------------------------
# SSH Key Pair
#------------------------------------------------------------------------------
output "ssh_keypair_name" {
  value       = try(aws_key_pair.this[0].key_name, null)
  description = "Name of SSH Key Pair."
}

output "ssh_keypair_id" {
  value       = try(aws_key_pair.this[0].key_pair_id, null)
  description = "ID of TFE SSH Key Pair."
}

output "ssh_keypair_fingerprint" {
  value       = try(aws_key_pair.this[0].fingerprint, null)
  description = "Fingerprint of SSH Key Pair."
}

#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------
output "kms_cmk_arn" {
  value       = try(aws_kms_key.this[0].arn, null)
  description = "ARN of KMS customer managed key (CMK)."
}

output "kms_cmk_id" {
  value       = try(aws_kms_key.this[0].key_id, null)
  description = "ID of KMS customer managed key (CMK)."
}

#------------------------------------------------------------------------------
# CloudWatch
#------------------------------------------------------------------------------
output "cloudwatch_log_group_name" {
  value       = try(nonsensitive(aws_cloudwatch_log_group.this[0].name), null)
  description = "Name of AWS CloudWatch Log Group."
}

#------------------------------------------------------------------------------

# Consul
#------------------------------------------------------------------------------

output "consul_agent_cert_arn" {
  value = try(aws_secretsmanager_secret.consul_tls_cert[0].arn, null)
}

output "consul_agent_key_arn" {
  value = try(aws_secretsmanager_secret.consul_tls_privkey[0].arn, null)
}

output "consul_ca_cert_arn" {
  value = try(aws_secretsmanager_secret.consul_tls_ca_bundle[0].arn, null)
}

output "consul_license_text_arn" {
  value = try(aws_secretsmanager_secret.consul_license[0].arn, null)
}

#------------------------------------------------------------------------------
# VAULT Secrets Manager
#------------------------------------------------------------------------------
output "vault_license_secret_arn" {
  value       = try(aws_secretsmanager_secret.vault_license[0].arn, null)
  description = "ARN of TFE license AWS Secrets Manager secret."
}

# output "vault_encryption_password_secret_arn" {
#   value       = try(aws_secretsmanager_secret.vault_encryption_password[0].arn, null)
#   description = "ARN of TFE encryption password AWS Secrets Manager secret."
# }

output "vault_tls_cert_secret_arn" {
  value       = try(aws_secretsmanager_secret.vault_tls_cert[0].arn, null)
  description = "ARN of TFE TLS certificate AWS Secrets Manager secret."
}

output "vault_tls_privkey_secret_arn" {
  value       = try(aws_secretsmanager_secret.vault_tls_privkey[0].arn, null)
  description = "ARN of TFE TLS private key AWS Secrets Manager secret."
}

output "vault_tls_ca_bundle_secret_arn" {
  value       = try(aws_secretsmanager_secret.vault_tls_ca_bundle[0].arn, null)
  description = "ARN of TFE TLS CA bundle AWS Secrets Manager secret."
}
