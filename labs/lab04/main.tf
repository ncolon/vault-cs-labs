
resource "vault_mount" "kv_v2" {
  path        = "kv-v2"
  type        = "kv"
  description = "KV Version 2 secret engine mount"
  options = {
    version = "2" # Specifies KV version 2
  }
}

resource "vault_mount" "kv_v2_finance" {
  path        = "kv-v2"
  type        = "kv"
  description = "KV Version 2 secret engine mount"
  options = {
    version = "2" # Specifies KV version 2
  }
  namespace = vault_namespace.finance.path_fq
}

resource "vault_kv_secret_v2" "userpass_secret" {
  mount = vault_mount.kv_v2.path
  name  = "userpass-secret"
  data_json = jsonencode({
    ping = "ERROR"
  })
}

resource "vault_kv_secret_v2" "ldap_secret" {
  mount = vault_mount.kv_v2.path
  name  = "ldap-secret"
  data_json = jsonencode({
    hello = "Guvna"
  })
}

resource "vault_kv_secret_v2" "deepaks_darkest_secret" {
  mount = vault_mount.kv_v2.path
  name  = "deepaks-darkest-secret"
  data_json = jsonencode({
    confession = "I love lamp"
  })
}

resource "vault_kv_secret_v2" "employee_secret" {
  mount = vault_mount.kv_v2.path
  name  = "employee-secret"
  data_json = jsonencode({
    doorCode = "0451"
  })
}

resource "vault_kv_secret_v2" "backdoor" {
  mount = vault_mount.kv_v2.path
  name  = "backdoor"
  data_json = jsonencode({
    selfDestruct = "0-0-0-Destruct-0"
  })
}

resource "vault_namespace" "admin" {
  path = "admin"
}

resource "vault_namespace" "finance" {
  path      = "finance"
  namespace = vault_namespace.admin.path
}

resource "vault_kv_secret_v2" "bank_info" {
  mount     = vault_mount.kv_v2_finance.path
  name      = "bank-info"
  namespace = vault_namespace.finance.path_fq
  data_json = jsonencode({
    bankAccount = "1234567890"
  })
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_auth_backend" "fake_ldap" {
  type = "userpass"
  path = "ldap"
}

resource "vault_auth_backend" "userpass_admin_ns" {
  type      = "userpass"
  namespace = vault_namespace.admin.path
}

resource "vault_auth_backend" "fake_ldap_admin_ns" {
  type      = "userpass"
  path      = "ldap"
  namespace = vault_namespace.admin.path
}

resource "vault_generic_endpoint" "deepak_user" {
  path = "auth/${vault_auth_backend.userpass.path}/users/deepak"
  data_json = jsonencode({
    password       = "myVaultUserPass"
    token_policies = ["userpass-policy", "deepak-secret-rw"]
  })
}

resource "vault_generic_endpoint" "deepak_ldap" {
  path = "auth/${vault_auth_backend.fake_ldap.path}/users/deepak"
  data_json = jsonencode({
    password       = "thispassword"
    token_policies = ["ldap-policy", "deepak-secret-rw"]
  })
}

resource "vault_generic_endpoint" "chun_ldap" {
  path = "auth/${vault_auth_backend.fake_ldap.path}/users/chun"
  data_json = jsonencode({
    password       = "thispassword"
    token_policies = ["engineering-ro"]
  })
}

resource "vault_generic_endpoint" "alice_admin_ns" {
  path = "auth/${vault_auth_backend.fake_ldap_admin_ns.path}/users/alice"
  data_json = jsonencode({
    password = "thispassword"
  })
  namespace = vault_namespace.admin.path
}


resource "vault_policy" "ldap_policy" {
  name   = "ldap-policy"
  policy = <<EOT
path "kv-v2/data/ldap-secret" {
  capabilities = ["read", "create", "update"]
}
EOT
}

resource "vault_policy" "userpass_policy" {
  name   = "userpass-policy"
  policy = <<EOT
path "kv-v2/data/userpass-secret" {
  capabilities = ["read", "create", "update"]
}
EOT
}

resource "vault_policy" "deepak_secret_rw" {
  name   = "deepak-secret-rw"
  policy = <<EOT
path "kv-v2/data/deepaks-darkest-secret" {
  capabilities = ["read", "create", "update"]
}
EOT
}

resource "vault_policy" "employee_secret_ro" {
  name   = "employee-secret-ro"
  policy = <<EOT
path "kv-v2/data/employee-secret" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "engineering_ro" {
  name   = "engineering-ro"
  policy = <<EOT
path "kv-v2/data/backdoor" {
  capabilities = ["read"]
}
EOT
}

resource "vault_policy" "bank_info_ro" {
  name      = "finance-ro"
  namespace = vault_namespace.finance.path_fq
  policy    = <<EOT
path "kv-v2/data/bank-info" {
  capabilities = ["read"]
}
EOT
}
