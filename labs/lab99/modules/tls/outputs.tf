output "tls_cert_fullpath" {
  value = "${path.cwd}/certs/ca-cert.pem"
}

output "ca_cert_content" {
  value = tls_self_signed_cert.ca.cert_pem
}

output "tls_key_content" {
  sensitive = true
  value     = tls_private_key.vault.private_key_pem
}

output "tls_cert_content" {
  value = tls_locally_signed_cert.vault.cert_pem
}

