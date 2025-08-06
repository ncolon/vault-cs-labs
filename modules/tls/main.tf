terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# 1. Generate CA private key
resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Generate self-signed CA certificate
resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name         = "vault.authority"
    organization        = "IBM"
    organizational_unit = "WW CS"
    country             = "US"
    province            = "North Carolina"
    locality            = "Raleigh"
  }

  validity_period_hours = 87600
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "key_encipherment",
    "digital_signature"
  ]
}

# 3. Generate TLS private key
resource "tls_private_key" "vault" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 4. Create certificate signing request (CSR)
resource "tls_cert_request" "vault" {
  private_key_pem = tls_private_key.vault.private_key_pem

  subject {
    common_name         = "vault.server"
    organization        = "IBM"
    organizational_unit = "WW CS"
    country             = "US"
    province            = "North Carolina"
    locality            = "Raleigh"
  }

  dns_names    = var.cert_fqdns
  ip_addresses = var.cert_ips
}

# 5. Sign TLS certificate using the CA
resource "tls_locally_signed_cert" "vault" {
  cert_request_pem = tls_cert_request.vault.cert_request_pem

  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "server_auth",
    "digital_signature",
    "key_encipherment"
  ]
}

# 6. Write output files
resource "local_file" "ca_key" {
  content  = tls_private_key.ca.private_key_pem
  filename = "${path.cwd}/certs/ca-key.pem"
}

resource "local_file" "ca_cert" {
  content  = tls_self_signed_cert.ca.cert_pem
  filename = "${path.cwd}/certs/ca-cert.pem"
}

resource "local_file" "tls_key" {
  content  = tls_private_key.vault.private_key_pem
  filename = "${path.cwd}/certs/tls.key"
}

resource "local_file" "tls_cert" {
  content  = tls_locally_signed_cert.vault.cert_pem
  filename = "${path.cwd}/certs/tls.crt"
}
