resource "vault_policy" "ross_policy" {
  name   = "ross-policy"
  policy = <<EOT
path "secrets-store/data/bob" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_policy" "batch_policy" {
  name   = "batch-policy"
  policy = <<EOT
path "secrets-store/data/herringbone" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_policy" "token_creation_policy" {
  name   = "token-creation-policy"
  policy = <<EOT
path "auth/token/create" {
  capabilities = ["create", "update"]
}
EOT
}

resource "vault_policy" "orphan_token_creation_policy" {
  name   = "orphan-token-creation-policy"
  policy = <<EOT
path "auth/token/create" {
  capabilities = ["create", "update"]
}
path "auth/token/revoke-orphan" {
  capabilities = ["delete", "update", "list", "sudo", "read"]
}
path "auth/token/lookup" {
  capabilities = ["list", "read", "update", "sudo"]
}
EOT
}

resource "vault_policy" "admin_policy" {
  name   = "admin-policy"
  policy = <<EOT
path "auth/token/*" {
  capabilities = ["list", "read", "create", "update", "delete", "sudo"]
}
path "secrets-store/data/*" {
  capabilities = ["list", "read", "create", "update", "delete"]
}
path "sys/policies/*" {
  capabilities = ["list", "read", "create", "update", "delete", "sudo"]
}
EOT
}

resource "vault_policy" "star_policy" {
  name   = "star-policy"
  policy = <<EOT
path "secrets-store/data/pleiades" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_mount" "secrets_store" {
  path        = "secrets-store"
  type        = "kv"
  description = "KV Version 2 secret engine mount"
  options = {
    version = "2" # Specifies KV version 2
  }
}

resource "vault_kv_secret_v2" "bob" {
  mount     = vault_mount.secrets_store.path
  name      = "bob"
  data_json = jsonencode({ passcode = "on-tv" })
}

resource "vault_kv_secret_v2" "herringbone" {
  mount     = vault_mount.secrets_store.path
  name      = "herringbone"
  data_json = jsonencode({ passcode = "wallpaper" })
}

