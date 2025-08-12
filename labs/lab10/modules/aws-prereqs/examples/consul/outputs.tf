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

output "bastion_public_ip" {
  value = module.prereqs.bastion_public_ip
}

#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------

output "agent_cert_arn" {
  value = module.prereqs.consul_agent_cert_arn
}

output "agent_key_arn" {
  value = module.prereqs.consul_agent_key_arn
}

output "ca_cert_arn" {
  value = module.prereqs.consul_ca_cert_arn
}

output "license_text_arn" {
  value = module.prereqs.consul_license_text_arn
}


#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------
output "cloudwatch_log_group_name" {
  value = module.prereqs.cloudwatch_log_group_name
}

#------------------------------------------------------------------------------
# S3
#------------------------------------------------------------------------------
output "s3_bucket_id" {
  value = module.prereqs.snapshot_s3_bucket_id
}
