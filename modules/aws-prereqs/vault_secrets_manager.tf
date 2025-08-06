

#------------------------------------------------------------------------------
# VAULT Secrets
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "vault_license" {
  count = var.vault_license_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.vault_license_secret_name}-${random_id.secret_suffix.id}"
  description = "Raw contents of the VAULT license file stored as a string."

  tags = merge(
    { Name = var.vault_license_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "vault_license" {
  count = var.vault_license_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.vault_license[0].id
  secret_string = var.vault_license_secret_value
}

#------------------------------------------------------------------------------
# Encryption Password
#------------------------------------------------------------------------------
# resource "aws_secretsmanager_secret" "vault_encryption_password" {
#   count = var.vault_encryption_password_secret_value != null ? 1 : 0

#   name        = "${var.friendly_name_prefix}-${var.vault_encryption_password_secret_name}-${random_id.secret_suffix.id}"
#   description = "String value of VAULT encryption password."

#   tags = merge(
#     { Name = var.vault_encryption_password_secret_name },
#     var.common_tags
#   )
# }

# resource "aws_secretsmanager_secret_version" "vault_encryption_password" {
#   count = var.vault_encryption_password_secret_value != null ? 1 : 0

#   secret_id     = aws_secretsmanager_secret.vault_encryption_password[0].id
#   secret_string = var.vault_encryption_password_secret_value
# }

#------------------------------------------------------------------------------
# TLS Certificate (PEM format)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "vault_tls_cert" {
  count = var.vault_tls_cert_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.vault_tls_cert_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of VAULT TLS certificate in PEM format."

  tags = merge(
    { Name = var.vault_tls_cert_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "vault_tls_cert" {
  count = var.vault_tls_cert_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.vault_tls_cert[0].id
  secret_string = base64decode(var.vault_tls_cert_secret_value_base64)
}

#------------------------------------------------------------------------------
# TLS Private Key (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "vault_tls_privkey" {
  count = var.vault_tls_privkey_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.vault_tls_privkey_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of VAULT TLS private key in PEM format."

  tags = merge(
    { Name = var.vault_tls_privkey_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "vault_tls_privkey" {
  count = var.vault_tls_privkey_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.vault_tls_privkey[0].id
  secret_string = base64decode(var.vault_tls_privkey_secret_value_base64)
}

#------------------------------------------------------------------------------
# TLS CA Bundle (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "vault_tls_ca_bundle" {
  count = var.vault_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.vault_tls_ca_bundle_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of VAULT TLS CA bundle in PEM format."

  tags = merge(
    { Name = var.vault_tls_ca_bundle_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "vault_tls_ca_bundle" {
  count = var.vault_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.vault_tls_ca_bundle[0].id
  secret_string = base64decode(var.vault_tls_ca_bundle_secret_value_base64)
}
