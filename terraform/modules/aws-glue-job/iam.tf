# create role for the etl glue job

resource "aws_iam_role" "glue" {
  name = "glue_etl_role_${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "glue" {
  name = "glue_etl_policy_${var.env}"
  role = aws_iam_role.glue.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.glue_scripts.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.glue_scripts.bucket}/*"
      ]
    }
  ]
}
EOF
}

# attach the 
