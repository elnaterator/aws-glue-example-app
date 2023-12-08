# common variables
locals {
  tags = {
    Author      = "elnaterator",
    Environment = local.env,
    Project     = "aws-glue-example-app"
  }
}

# invoke the aws-glue-job module
module "glue_job" {
  source = "../../modules/aws-glue-job"

  env        = local.env
  region     = local.region
  account_id = local.account_id
  tags       = local.tags
}
