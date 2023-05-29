import json
import boto3
import botocore

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # TODO implement
        print("Received event: " + json.dumps(event, indent = 2))
        ev_py = json.loads(str(json.dumps(event, indent = 2)))
        bucket_name = ev_py['detail']['requestParameters']['bucketName']
        print(bucket_name)
        #Define the name of the S3 bucket where server access logs will be saved
        log_bucket_name = 'targetbucket'
        #Define the prefix to be used for the server access log object key
        log_prefix = f'{bucket_name}_s3-server-access-logs/'
        response0 = s3.put_object(
            Bucket = log_bucket_name,
            Key = log_prefix

        )
        #Define the logging configuration for the S3 bucket
        response1 = s3.put_bucket_logging(
            Bucket=bucket_name,
            BucketLoggingStatus={
                'LoggingEnabled': {
                    'TargetBucket': log_bucket_name,
                    'TargetPrefix': log_prefix
                }
            }
        )

        response2 = s3.put_bucket_versioning(
            Bucket=bucket_name,
            VersioningConfiguration={
                'Status': 'Enabled'
            }
        )
        print(response0)
        print(response1)
        print(response2)
        