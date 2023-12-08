# create aws glue etl job

resource "aws_glue_job" "glue_job" {

  name     = "aws-glue-job"
  role_arn = aws_iam_role.glue.arn

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_scripts.bucket}/glue_scripts/example_app.py"
    python_version  = "3"
  }

  default_arguments = {
    "--TempDir"             = "s3://${aws_s3_bucket.glue_scripts.bucket}/tmp"
    "--job-bookmark-option" = "job-bookmark-disable"
    "--job-language"        = "python"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  timeout = 60
  tags    = merge(var.tags, { Name = "aws-glue-example-app-${var.env}" })

}
