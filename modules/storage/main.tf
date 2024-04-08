resource "aws_s3_bucket" "bucket" {
  bucket = "three-tier-storage-app-${var.environment}"
  tags = merge({Name = "s3-image-storage"}, var.tags)
}