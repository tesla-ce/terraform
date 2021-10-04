resource "aws_s3_bucket" "private" {
  bucket = var.storage_bucket_name
  acl    = "private"

  tags = {
    Name = "Private S3 Bucket"
  }
}

resource "aws_s3_bucket" "public" {
  bucket = var.storage_public_bucket_name
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = var.storage_cors_allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  tags = {
    Name = "Public S3 Bucket"
  }
}
