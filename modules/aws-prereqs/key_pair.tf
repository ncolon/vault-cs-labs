#------------------------------------------------------------------------------
# EC2 Key Pair
#------------------------------------------------------------------------------
resource "aws_key_pair" "this" {
  count = var.create_ec2_ssh_keypair ? 1 : 0

  key_name   = var.ec2_ssh_keypair_name
  public_key = tls_private_key.this[0].public_key_openssh

  tags = merge(
    { Name = var.ec2_ssh_keypair_name },
    var.common_tags
  )
}

resource "tls_private_key" "this" {
  count = var.create_ec2_ssh_keypair ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  count = var.create_ec2_ssh_keypair ? 1 : 0

  content         = tls_private_key.this[0].private_key_pem
  filename        = "${path.cwd}/certs/vault_rsa"
  file_permission = 0400
}

resource "local_file" "ssh_key_public" {
  count = var.create_ec2_ssh_keypair ? 1 : 0

  content         = tls_private_key.this[0].public_key_openssh
  filename        = "${path.cwd}/certs/vault_rsa.pub"
  file_permission = 0400
}

