resource "aws_cloudwatch_log_group" "this" {
  count = var.create_cloudwatch_log_group ? 1 : 0

  name              = "${var.friendly_name_prefix}-${var.cloudwatch_log_group_name}"
  retention_in_days = var.log_group_retention_days
  kms_key_id        = var.create_kms_cmk && var.encrypt_cloudwatch_log_group ? aws_kms_key.this[0].arn : null

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-${var.cloudwatch_log_group_name}" },
    var.common_tags
  )
}
