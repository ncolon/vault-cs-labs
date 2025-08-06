# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "aws_security_group" "internal" {
  count = var.vault_count
  name  = "${var.prefix}-${count.index}-sg"
}

resource "aws_security_group_rule" "vault_cluster_peer_rule" {
  for_each = {
    for pair in flatten([
      for i in range(var.vault_count) : [
        for j in range(var.vault_count) : {
          key       = "${i}-${j}"
          source_sg = data.aws_security_group.internal[j].id
          target_sg = data.aws_security_group.internal[i].id
        } if i != j
      ]
    ]) : pair.key => pair
  }

  type                     = "ingress"
  from_port                = 8201
  to_port                  = 8201
  protocol                 = "tcp"
  security_group_id        = each.value.target_sg
  source_security_group_id = each.value.source_sg
}
