# output "vault_cli_config" {
#   description = "Environment variables to configure the Vault CLI"
#   value       = module.vault.*.vault_cli_config
# }

# output "vault_ca_path" {
#   description = "Environment variables to configure the Vault CLI"
#   value       = "export VAULT_CACERT=${module.tls.tls_cert_fullpath}"
# }

output "bastion_public_ip" {
  value       = module.prereqs.bastion_public_ip
  description = "Public IP of bastion EC2 instance."
}

# output "internal_loadbalancer_cluster_url" {
#   value = join("\n", [
#     for idx, url in flatten(module.internallb.*.vault_internal_load_balancer_name) :
#     format("      export VAULT_CLUSTER_URL_%d=https://%s:8201", idx, url)
#   ])
# }


# output "vault_cli_config" {
#   description = "Environment variables to configure the Vault CLI for each Vault cluster"
#   value = [
#     for idx, config in module.vault.*.vault_cli_config : <<-EOT
#         # VAULT CLUSTER ${idx + 1} CONFIG
#         ${replace(trimspace(config),
#     "export VAULT_CACERT=<path/to/ca-certificate>",
#     "export VAULT_CACERT=${module.tls.tls_cert_fullpath}"
#     )}
#     ${format(
#     "    # export VAULT_INTERNAL_CLUSTER_URL=https://%s:8201",
#     element(flatten(module.internallb.*.vault_internal_load_balancer_name), idx)
# )}
#     EOT
# ]
# }


output "vault_cli_config" {
  description = "Environment variables to configure the Vault CLI for each Vault cluster"
  value = [
    for idx, config in module.vault.*.vault_cli_config : <<-EOT
        # VAULT CLUSTER ${idx + 1} CONFIG
        ${replace(trimspace(config),
    "export VAULT_CACERT=<path/to/ca-certificate>",
    "export VAULT_CACERT=${module.tls.tls_cert_fullpath}"
)}
   EOT
]
}
