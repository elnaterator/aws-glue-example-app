# create an s3 bucket for my glue etl data

resource "aws_s3_bucket" "glue_scripts" {
  bucket = "elnaterator-aws-glue-example-app-${var.env}"
  tags   = merge(var.tags, { Name = "elnaterator-aws-glue-example-app-${var.env}" })
}

# add server side encryption to s3 bucket

resource "aws_s3_bucket_server_side_encryption_configuration" "glue_scripts" {
  bucket = aws_s3_bucket.glue_scripts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

