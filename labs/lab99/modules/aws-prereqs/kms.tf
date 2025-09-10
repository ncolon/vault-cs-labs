#------------------------------------------------------------------------------
# KMS Customer Managed Key (CMK)
#------------------------------------------------------------------------------
# locals {
#   kms_cmk_key_policy_args = {
#     account_id = data.aws_caller_identity.current.account_id
#     region     = data.aws_region.current.name
#   }
# }

data "aws_iam_policy_document" "kms_cmk" {
  count = var.create_kms_cmk ? 1 : 0

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow service-linked role use of the CMK"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
    }
    actions   = ["kms:CreateGrant"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }

  statement {
    sid = "CloudWatchLogs"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.region}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "this" {
  count = var.create_kms_cmk ? 1 : 0

  description                        = "AWS KMS customer-managed key (CMK) for encrypting infrastructure resources."
  key_usage                          = "ENCRYPT_DECRYPT"
  deletion_window_in_days            = var.kms_cmk_deletion_window
  is_enabled                         = true
  enable_key_rotation                = var.kms_cmk_enable_key_rotation
  policy                             = var.kms_allow_asg_to_cmk ? data.aws_iam_policy_document.kms_cmk[0].json : null
  bypass_policy_lockout_safety_check = true
  tags = merge(
    { Name = "${var.friendly_name_prefix}-kms-cmk" },
    var.common_tags
  )
}

#------------------------------------------------------------------------------
# KMS Customer Managed Key (CMK) Alias
#------------------------------------------------------------------------------
resource "aws_kms_alias" "this" {
  count = var.create_kms_cmk && var.kms_cmk_alias != null ? 1 : 0

  name          = "alias/${var.kms_cmk_alias}"
  target_key_id = aws_kms_key.this[0].id
}

