// Jenkins pipeline to run terraform in terraform/environments/dev then deploy AWS Glue ETL Job from app dir.
// This is a simple example, not for production use.

pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION = 'us-west-2'
    }
    // choose parameter, which environment to deploy to
    parameters {
        choice(choices: ['dev', 'stg'], description: 'Choose environment to deploy to', name: 'ENVIRONMENT')
    }
    stages {
        stage('Prep Infra') {
            steps {
                dir("terraform/environments/${params.ENVIRONMENT}") {
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform plan -out=tfplan'
                    sh 'terraform show tfplan'
                }
            }
        }
        stage('Confirm Infra') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: "Deploy to ${params.ENVIRONMENT}?", ok: 'Deploy'
                }
            }
        }
        stage('Deploy Infra') {
            steps {
                dir("terraform/environments/${params.ENVIRONMENT}") {
                    sh 'terraform apply tfplan -auto-approve'
                }
            }
        }
        stage('Deploy App Code') {
            steps {
                dir('app') {
                    // push glue etl script to s3 bucket
                    sh 'aws s3 cp src/glueetl.py s3://my-bucket/'
                    sh 'aws glue create-job --name "glue-etl-job" --role-arn "arn:aws:iam::123456789012:role/service-role/AWSGlueServiceRole-DefaultRole" --command \'{"Name": "glueetl","ScriptLocation": "s3://my-bucket/glueetl.py"}\' --default-arguments \'{"--TempDir": "s3://my-bucket/temp/","--job-bookmark-option": "job-bookmark-disable"}\''
                }
            }
        }
    }
}
```