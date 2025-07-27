output "vault_cli_config" {
  description = "Environment variables to configure the Vault CLI"
  value       = module.vault.vault_cli_config
}

output "vault_ca_path" {
  description = "Environment variables to configure the Vault CLI"
  value       = <<-EOF
    export VAULT_CACERT="${module.tls.tls_cert_fullpath}"
  EOF
}

output "bastion_public_ip" {
  value       = module.prereqs.bastion_public_ip
  description = "Public IP of bastion EC2 instance."
}

