variable "cert_fqdns" {
  type    = list(any)
  default = ["vault.server", "*.ec2.internal", "*.amazonaws.com"]
}

variable "cert_ips" {
  type    = list(any)
  default = ["127.0.0.1"]
}
