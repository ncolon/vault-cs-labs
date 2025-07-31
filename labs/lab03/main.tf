# vault secrets enable -version=2 -path=cdf kv
# vault secrets enable -path=cdf-certs pki
# vault secrets enable aws
# vault auth enable userpass
# vault write auth/userpass/users/cdf-admin password=passw0rd
# vault kv put cdf/imr-credentials date_commissioned=01/27/1997 endpoint=/imr-008-09-34 passcode=0ld_mans_war security-protocols="[ftl-transport, surveillance, gts-comms]"
# for role in perry thomas ruiz alan sagan boutin dirac wilson gau daquin; do
#   vault kv put cdf/s3/aws_role/$role aws-role=$role-role
# done
# for system in s3 ec2 rds eks iam elasticache ebs efs vpc wan; do
#   vault kv put cdf/$system/aws_role/perry key1=value1 key2=value2
# done

resource "vault_mount" "cdf_kv" {
  path    = "cdf"
  type    = "kv"
  options = { version = "2" }
}

resource "vault_mount" "cdf_certs" {
  path = "cdf-certs"
  type = "pki"
}

resource "vault_pki_secret_backend_config_urls" "pki_urls" {
  backend = vault_mount.cdf_certs.path
}

resource "vault_pki_secret_backend_root_cert" "pki_root" {
  backend     = vault_mount.cdf_certs.path
  type        = "internal"
  common_name = "cdf.com"
  ttl         = "87600h" # 10 years
}

resource "vault_pki_secret_backend_role" "imr" {
  backend          = vault_mount.cdf_certs.path
  name             = "imr"
  allowed_domains  = ["cdf.com"]
  allow_subdomains = true
  max_ttl          = "8760h" # 1 year
}

resource "vault_mount" "aws" {
  path = "aws"
  type = "aws"
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "cdf_admin_user" {
  path = "auth/${vault_auth_backend.userpass.path}/users/cdf-admin"
  data_json = jsonencode({
    password = "passw0rd"
  })
}

resource "vault_kv_secret_v2" "imr_credentials" {
  mount = vault_mount.cdf_kv.path
  name  = "imr-credentials"
  data_json = jsonencode({
    date_commissioned  = "01/27/1997"
    endpoint           = "/imr-008-09-34"
    passcode           = "0ld_mans_war"
    security-protocols = "[ftl-transport, surveillance, gts-comms]"
  })
}

# AWS roles for each user
locals {
  roles   = ["perry", "thomas", "ruiz", "alan", "sagan", "boutin", "dirac", "wilson", "gau", "daquin"]
  systems = ["s3", "ec2", "rds", "eks", "iam", "elasticache", "ebs", "efs", "vpc", "wan"]
}

resource "vault_kv_secret_v2" "aws_role" {
  for_each = toset(local.roles)
  mount    = vault_mount.cdf_kv.path
  name     = "s3/aws_role/${each.key}"
  data_json = jsonencode({
    aws-role = "${each.key}-role"
  })
}

resource "vault_kv_secret_v2" "aws_role_systems" {
  for_each = { for role in local.systems : role => role }
  mount    = vault_mount.cdf_kv.path
  name     = "${each.key}/aws_role/perry"
  data_json = jsonencode({
    key1 = "value1"
    key2 = "value2"
  })
}

resource "vault_policy" "cdf_secrets" {
  name = "cdf_secrets"

  policy = <<EOT
path "cdf/metadata" {
  capabilities = ["list"]
}
EOT
}

resource "vault_generic_endpoint" "junie_user" {
  path = "auth/${vault_auth_backend.userpass.path}/users/junie"
  data_json = jsonencode({
    password       = "calico-cat"
    token_policies = ["default", "${vault_policy.cdf_secrets.name}"]
  })
}

resource "vault_generic_endpoint" "mimosa_user" {
  path = "auth/${vault_auth_backend.userpass.path}/users/mimosa"
  data_json = jsonencode({
    password       = "white-cat"
    token_policies = ["default", "${vault_policy.cdf_secrets.name}"]
  })
}

resource "vault_identity_entity" "mimosa" {
  name     = "Mimosa"
  policies = ["cdf_secrets"]
  metadata = {
    role = "AWS Supervisor"
  }
}

resource "vault_identity_entity" "junie" {
  name     = "Junie"
  policies = ["cdf_secrets"]
  metadata = {
    role = "Project Manager"
  }
}

resource "vault_identity_entity_alias" "junie_alias" {
  name           = "junie"                              # Username in auth method
  mount_accessor = vault_auth_backend.userpass.accessor # Accessor of userpass backend
  canonical_id   = vault_identity_entity.junie.id       # ID of the entity
}

resource "vault_identity_entity_alias" "mimosa_alias" {
  name           = "mimosa"                             # Username in auth method
  mount_accessor = vault_auth_backend.userpass.accessor # Accessor of userpass backend
  canonical_id   = vault_identity_entity.mimosa.id      # ID of the entity
}

resource "local_file" "mimosa" {
  content  = vault_identity_entity_alias.mimosa_alias.canonical_id
  filename = "${path.cwd}/mimosa_id.txt"
}

resource "local_file" "junie" {
  content  = vault_identity_entity_alias.junie_alias.canonical_id
  filename = "${path.cwd}/junie_id.txt"
}
