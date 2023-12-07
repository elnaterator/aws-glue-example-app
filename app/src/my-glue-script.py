# bootstrap a basic glue ETL script with pyspark 3.3.0 and boto3 1.33.9

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# add boto3 to the path
sys.path.insert(0, "/opt/amazon/lib/python3.6/site-packages")

# create the glue context
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# create the job
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# read file from s3 bucket
df = spark.read.csv("s3://my-bucket/my-file.csv", header=True)

# sort the data by last_name and first_name
df = df.sort("last_name", "first_name", ascending=True)


job.commit()
