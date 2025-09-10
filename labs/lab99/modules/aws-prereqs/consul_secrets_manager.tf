#------------------------------------------------------------------------------
# Consul Secrets
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# License
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "consul_license" {
  count = var.consul_license_secret_value != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.consul_license_secret_name}"
  description = "Raw contents of the Consul license file stored as a string."

  tags = merge(
    { Name = var.consul_license_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "consul_license" {
  count = var.consul_license_secret_value != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.consul_license[0].id
  secret_string = var.consul_license_secret_value
}


#------------------------------------------------------------------------------
# TLS Certificate (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "consul_tls_cert" {
  count = var.consul_tls_cert_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.consul_tls_cert_secret_name}"
  description = "Base64-encoded string value of Consul TLS certificate in PEM format."

  tags = merge(
    { Name = var.consul_tls_cert_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "consul_tls_cert" {
  count = var.consul_tls_cert_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.consul_tls_cert[0].id
  secret_string = var.consul_tls_cert_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS Private Key (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "consul_tls_privkey" {
  count = var.consul_tls_privkey_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.consul_tls_privkey_secret_name}"
  description = "Base64-encoded string value of Consul TLS private key in PEM format."

  tags = merge(
    { Name = var.consul_tls_privkey_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "consul_tls_privkey" {
  count = var.consul_tls_privkey_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.consul_tls_privkey[0].id
  secret_string = var.consul_tls_privkey_secret_value_base64
}

#------------------------------------------------------------------------------
# TLS CA Bundle (PEM format, base64-encoded)
#------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "consul_tls_ca_bundle" {
  count = var.consul_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  name        = "${var.friendly_name_prefix}-${var.consul_tls_ca_bundle_secret_name}"
  description = "Base64-encoded string value of Consul TLS CA bundle in PEM format."

  tags = merge(
    { Name = var.consul_tls_ca_bundle_secret_name },
    var.common_tags
  )
}

resource "aws_secretsmanager_secret_version" "consul_tls_ca_bundle" {
  count = var.consul_tls_ca_bundle_secret_value_base64 != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.consul_tls_ca_bundle[0].id
  secret_string = var.consul_tls_ca_bundle_secret_value_base64
}
