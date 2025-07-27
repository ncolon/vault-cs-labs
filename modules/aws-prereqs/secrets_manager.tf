#------------------------------------------------------------------------------
# TFE Secrets
#------------------------------------------------------------------------------

resource "random_id" "secret_suffix" {
  byte_length = 4
}

#------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_license" {
  count = var.tfe_license_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_license_secret_name}-${random_id.secret_suffix.id}"
  description = "Raw contents of the TFE license file stored as a string."

  tags = merge(
    { Name = var.tfe_license_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_license" {
  count = var.tfe_license_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_license[0].id
  secret_string = var.tfe_license_secret_value
}

#------------------------------------------------------------------------------
# Encryption Password
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_encryption_password" {
  count = var.tfe_encryption_password_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_encryption_password_secret_name}-${random_id.secret_suffix.id}"
  description = "String value of TFE encryption password."

  tags = merge(
    { Name = var.tfe_encryption_password_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_encryption_password" {
  count = var.tfe_encryption_password_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_encryption_password[0].id
  secret_string = var.tfe_encryption_password_secret_value
}

#------------------------------------------------------------------------------
# Database Password
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_database_password" {
  count = var.tfe_database_password_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_database_password_secret_name}-${random_id.secret_suffix.id}"
  description = "String value of TFE database password."

  tags = merge(
    { Name = var.tfe_database_password_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_database_password" {
  count = var.tfe_database_password_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_database_password[0].id
  secret_string = var.tfe_database_password_secret_value
}

#------------------------------------------------------------------------------
# Redis Password
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_redis_password" {
  count = var.tfe_redis_password_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_redis_password_secret_name}-${random_id.secret_suffix.id}"
  description = "String value of TFE redis password."

  tags = merge(
    { Name = var.tfe_redis_password_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_redis_password" {
  count = var.tfe_redis_password_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_redis_password[0].id
  secret_string = var.tfe_redis_password_secret_value
}

#------------------------------------------------------------------------------
# TLS Certificate (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_tls_cert" {
  count = var.tfe_tls_cert_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_tls_cert_secret_name}-${random_id.secret_suffix.id}"
  description = "string value of TFE TLS certificate in PEM format."

  tags = merge(
    { Name = var.tfe_tls_cert_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_tls_cert" {
  count = var.tfe_tls_cert_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_tls_cert[0].id
  secret_string = var.tfe_tls_cert_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS Private Key (PEM format)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_tls_privkey" {
  count = var.tfe_tls_privkey_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_tls_privkey_secret_name}-${random_id.secret_suffix.id}"
  description = "string value of TFE TLS private key in PEM format."

  tags = merge(
    { Name = var.tfe_tls_privkey_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_tls_privkey" {
  count = var.tfe_tls_privkey_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_tls_privkey[0].id
  secret_string = var.tfe_tls_privkey_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS CA Bundle (PEM format)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "tfe_tls_ca_bundle" {
  count = var.tfe_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.tfe_tls_ca_bundle_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of TFE TLS CA bundle in PEM format."

  tags = merge(
    { Name = var.tfe_tls_ca_bundle_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "tfe_tls_ca_bundle" {
  count = var.tfe_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.tfe_tls_ca_bundle[0].id
  secret_string = var.tfe_tls_ca_bundle_secret_value_base64
}

#------------------------------------------------------------------------------
# Boundary Secrets
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "boundary_license" {
  count = var.boundary_license_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.boundary_license_secret_name}-${random_id.secret_suffix.id}"
  description = "Raw contents of the Boundary license file stored as a string."

  tags = merge(
    { Name = var.boundary_license_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "boundary_license" {
  count = var.boundary_license_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.boundary_license[0].id
  secret_string = var.boundary_license_secret_value
}

#------------------------------------------------------------------------------
# Database Password
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "boundary_database_password" {
  count = var.boundary_database_password_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.boundary_database_password_secret_name}-${random_id.secret_suffix.id}"
  description = "String value of Boundary database password."

  tags = merge(
    { Name = var.boundary_database_password_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "boundary_database_password" {
  count = var.boundary_database_password_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.boundary_database_password[0].id
  secret_string = var.boundary_database_password_secret_value
}

#------------------------------------------------------------------------------
# TLS Certificate (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "boundary_tls_cert" {
  count = var.boundary_tls_cert_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.boundary_tls_cert_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of Boundary TLS certificate in PEM format."

  tags = merge(
    { Name = var.boundary_tls_cert_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "boundary_tls_cert" {
  count = var.boundary_tls_cert_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.boundary_tls_cert[0].id
  secret_string = var.boundary_tls_cert_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS Private Key (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "boundary_tls_privkey" {
  count = var.boundary_tls_privkey_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.boundary_tls_privkey_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of Boundary TLS private key in PEM format."

  tags = merge(
    { Name = var.boundary_tls_privkey_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "boundary_tls_privkey" {
  count = var.boundary_tls_privkey_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.boundary_tls_privkey[0].id
  secret_string = var.boundary_tls_privkey_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS CA Bundle (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "boundary_tls_ca_bundle" {
  count = var.boundary_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.boundary_tls_ca_bundle_secret_name}-${random_id.secret_suffix.id}"
  description = "Base64-encoded string value of Boundary TLS CA bundle in PEM format."

  tags = merge(
    { Name = var.boundary_tls_ca_bundle_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "boundary_tls_ca_bundle" {
  count = var.boundary_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.boundary_tls_ca_bundle[0].id
  secret_string = var.boundary_tls_ca_bundle_secret_value_base64
}

#------------------------------------------------------------------------------
# Nomad Secrets
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "nomad_license" {
  count = var.nomad_license_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.nomad_license_secret_name}"
  description = "Raw contents of the Nomad license file stored as a string."

  tags = merge(
    { Name = var.nomad_license_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "nomad_license" {
  count = var.nomad_license_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.nomad_license[0].id
  secret_string = var.nomad_license_secret_value
}

#------------------------------------------------------------------------------
# Gossip Encryption Key
#------------------------------------------------------------------------------

resource "aws_secretsmanager_secret" "nomad_gossip_encryption_key" {
  count = var.nomad_gossip_encryption_key_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.nomad_gossip_encryption_key_secret_name}"
  description = "Value of Nomad Gossip Encryption key to create as AWS Secrets Manager secret."

  tags = merge(
    { Name = var.nomad_gossip_encryption_key_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "nomad_gossip_encryption_key" {
  count = var.nomad_gossip_encryption_key_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.nomad_gossip_encryption_key[0].id
  secret_string = var.nomad_gossip_encryption_key_secret_value
}

#------------------------------------------------------------------------------
# TLS Certificate (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "nomad_tls_cert" {
  count = var.nomad_tls_cert_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.nomad_tls_cert_secret_name}"
  description = "Base64-encoded string value of Nomad TLS certificate in PEM format."

  tags = merge(
    { Name = var.nomad_tls_cert_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "nomad_tls_cert" {
  count = var.nomad_tls_cert_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.nomad_tls_cert[0].id
  secret_string = var.nomad_tls_cert_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS Private Key (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "nomad_tls_privkey" {
  count = var.nomad_tls_privkey_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.nomad_tls_privkey_secret_name}"
  description = "Base64-encoded string value of Nomad TLS private key in PEM format."

  tags = merge(
    { Name = var.nomad_tls_privkey_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "nomad_tls_privkey" {
  count = var.nomad_tls_privkey_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.nomad_tls_privkey[0].id
  secret_string = var.nomad_tls_privkey_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS CA Bundle (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "nomad_tls_ca_bundle" {
  count = var.nomad_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.nomad_tls_ca_bundle_secret_name}"
  description = "Base64-encoded string value of Nomad TLS CA bundle in PEM format."

  tags = merge(
    { Name = var.nomad_tls_ca_bundle_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "nomad_tls_ca_bundle" {
  count = var.nomad_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.nomad_tls_ca_bundle[0].id
  secret_string = var.nomad_tls_ca_bundle_secret_value_base64
}

