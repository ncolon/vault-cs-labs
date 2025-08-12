resource "tls_private_key" "nomad_ca" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "nomad_ca" {
  private_key_pem = tls_private_key.nomad_ca.private_key_pem

  subject {
    common_name    = "Nomad Agent CA"
    country        = "US"
    locality       = "San Francisco"
    street_address = ["101 Second Street"]
    organization   = "HashiCorp Inc."
    postal_code    = "94105"
    province       = "CA"
  }

  validity_period_hours = 91 * 24

  allowed_uses = [
    "cert_signing",
    "digital_signature",
    "crl_signing",
  ]

  is_ca_certificate  = true
  set_subject_key_id = true
}

resource "tls_private_key" "server" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

#Change the `us-east-1` to your desired Nomad region. This can match the AWS region resources are deploy or could be different.
resource "tls_cert_request" "server" {
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name = "server.us-east-1.nomad"
  }

  dns_names = [
    "server.us-east-1.nomad",
    "client.us-east-1.nomad",
    "localhost",
  ]

  ip_addresses = [
    "127.0.0.1"
  ]
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_private_key_pem = tls_private_key.nomad_ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.nomad_ca.cert_pem

  validity_period_hours = 31 * 24

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
  ]

  set_subject_key_id = true
}

resource "tls_private_key" "server_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}