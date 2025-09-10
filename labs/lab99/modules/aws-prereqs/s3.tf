#------------------------------------------------------------------------------
# S3 bucket
#------------------------------------------------------------------------------
resource "aws_s3_bucket" "snapshot" {
  count = var.create_snapshot_s3_bucket ? 1 : 0

  bucket = "${var.friendly_name_prefix}-snapshot-${data.aws_region.current.region}-${data.aws_caller_identity.current.account_id}"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-snapshot-${data.aws_region.current.region}-${data.aws_caller_identity.current.account_id}" },
    var.common_tags
  )
}

resource "aws_s3_bucket_public_access_block" "tfe" {
  count = var.create_snapshot_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.snapshot[0].id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

output "snapshot_s3_bucket_id" {
  value = var.create_snapshot_s3_bucket ? aws_s3_bucket.snapshot[0].id : null
}
