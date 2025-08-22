Automate the implementation of Versioning and Server Access Logging for all your S3 Buckets using AWS Lambda and Terraform


Versioning in Amazon S3 is a means of keeping multiple variants of an object in the same Bucket. With S3 Versioning feature you can preserve, retrieve, and restore every version of every object stored in the Buckets.

Server access logging on the other hand, provides detailed records for the requests that are made to a bucket. While management evens like “GetBucket”, “ListBucket”, “CreateBucket” are automatically captured in your CloudTrail Event History, the same is not true for data events like “CreateObject”, “DeleteObject”, etc.

The requirement here is simply, the data logs for multiple Buckets in a particular region in the account to be delivered to a centralized location, in our case a target S3 Bucket, so that the same can be used later for detailed security and access audits.

This is a walkthrough for anybody looking to automate S3 Versioning and Server Access Log Delivery for all the S3 Buckets in a particular region in their account to a target Bucket in the same region using AWS Lambda.

I have used Terraform to spin up and implement this, where Terraform takes care of creating your target Bucket with necessary permissions, the EventBridge rule, Lambda Function with the execution role having the discussed permissions, the EventBridge trigger mapping to the Lambda Function.



<img width="621" height="420" alt="image" src="https://github.com/user-attachments/assets/201ed6a8-ab5b-49fc-aa3d-bae4dd414463" />
