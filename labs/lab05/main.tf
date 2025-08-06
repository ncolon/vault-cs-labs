resource "vault_policy" "admin_policy" {
  name   = "admin_policy"
  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}
