# bootstrap a basic glue ETL script with pyspark 3.3.0 and boto3 1.33.9

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# create the glue context
glueContext = GlueContext(SparkContext.getOrCreate())
spark = glueContext.spark_session


# create the transform data function
def transform_data(df):
    # TODO perform business logic here
    df = df.sort("last_name")
    return df


# capture arguments
args = getResolvedOptions(
    sys.argv, ["JOB_NAME", "BUCKET_NAME", "INPUT_FILE_PATH", "OUTPUT_FILE_PATH"]
)
job_name = args["JOB_NAME"]
bucket_name = args["BUCKET_NAME"]
input_file_path = args["INPUT_FILE_PATH"]
output_file_path = args["OUTPUT_FILE_PATH"]

# create the job
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# read file from s3 bucket
df = spark.read.csv(f"s3://{bucket_name}/{input_file_path}", header=True)

# transform data
df = transform_data(df)

# write the data to s3 as parquet
df.write.parquet(f"s3://{bucket_name}/{output_file_path}", header=True)

job.commit()
