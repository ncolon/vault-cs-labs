resource "vault_namespace" "tennant_1" {
  path = "tennant-1"
}

resource "vault_mount" "pki" {
  path        = "pki"
  type        = "pki"
  description = "PKI secrets engine for tennant-1"
  namespace   = vault_namespace.tennant_1.path_fq
}

resource "vault_pki_secret_backend_config_urls" "pki_urls" {
  backend   = vault_mount.pki.path
  namespace = vault_namespace.tennant_1.path_fq

  issuing_certificates    = ["https://localhost:8200/v1/pki/ca"]
  crl_distribution_points = ["https://localhost:8200/v1/pki/crl"]
}

resource "vault_pki_secret_backend_root_cert" "pki_root" {
  backend     = vault_mount.pki.path
  namespace   = vault_namespace.tennant_1.path_fq
  type        = "internal"
  common_name = "tennant-1.example.com"
  ttl         = "87600h" # 10 years
}

resource "vault_pki_secret_backend_role" "tennant1" {
  backend          = vault_mount.pki.path
  namespace        = vault_namespace.tennant_1.path_fq
  name             = "tennant1"
  allowed_domains  = ["tennant-1.example.com"]
  allow_subdomains = true
  max_ttl          = "8760h" # 1 year
}
