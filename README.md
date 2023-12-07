# AWS Glue Example App

Example AWS Glue ETL Job with infrastructure and app that reads from an s3 bucket, performs some basic transformations, sorts, writes back to s3.

# Quick Start

## Terraform Infrastructure

Create the AWS infrastructure for the ETL job to run on

Prereqs
 - Bucket named `elnaterator-terraform-state-bucket`
 - AWS creds to role/user with access to terraform state bucket and glue resources

Steps

    # stand up dev environment
    cd terraform/environments/dev
    terraform plan -out=myplan.out
    terraform apply myplan.out

## Deploy ETL Job

# Links

* https://github.com/awslabs/aws-glue-libs
* https://github.com/aws-samples/aws-glue-samples/tree/master/examples
* https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python.html
* https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python-libraries.html
* https://python-poetry.org/docs/dependency-specification/#git-dependencies

