# Create S3 bucket
resource "aws_s3_bucket" "s3-tf-project" {
  bucket = var.aws_s3_bucket

  tags = {
    Name        = "s3-tf-project"
    Environment = "Dev"
  }
}

# Allow public access
resource "aws_s3_bucket_public_access_block" "s3-default-project" {
  bucket = aws_s3_bucket.s3-tf-project.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-access" {
  bucket = aws_s3_bucket.s3-tf-project.id
  policy = data.aws_iam_policy_document.bucket-access.json
}

data "aws_iam_policy_document" "bucket-access" {
  statement {
    sid       = "AllowPublicRead"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.s3-tf-project.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]
  }
  depends_on = [aws_s3_bucket_public_access_block.s3-default-project]
}

/*
# Configure bucket versioning
resource "aws_s3_bucket_versioning" "jonnie-s3-bucket-versioning" {
    bucket = aws_s3_bucket.jonnie-s3-bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}
*/