# output bucket name, glue job name, and role arn

output "bucket_name" {
  value = aws_s3_bucket.glue_scripts.bucket
}

output "glue_job_name" {
  value = aws_glue_job.glue_job.name
}

output "glue_role_arn" {
  value = aws_iam_role.glue.arn
}
