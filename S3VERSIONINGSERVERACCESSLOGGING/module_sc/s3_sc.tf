resource "aws_s3_bucket" "log-collection-bucket"{
    bucket = var.aws_tg
    tags = {
        Notes = "Created for collecting server access logs of s3 buckets"
    }
}

resource "aws_s3_bucket_versioning" "vers" {
    bucket = aws_s3_bucket.log-collection-bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log-collection-sse" {
    bucket = aws_s3_bucket.log-collection-bucket.id
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
        }
    }
}

resource "aws_s3_bucket_policy" "log-collection-bucket-policy" {
    bucket = aws_s3_bucket.log-collection-bucket.id
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "S3ServerAccessLogsPolicy",
                "Effect": "Allow",
                "Principal": {
                    "Service": "logging.s3.amazonaws.com"
                },
                "Action": "s3:PutObject",
                "Resource": "arn:aws:s3:::${var.aws_tg}/*"
            },
            {
                "Sid": "AllowSSLRequestsOnly",
                "Effect": "Deny",
                "Principal": "*",
                "Action": "s3:*",
                "Resource": [
                    "arn:aws:s3:::${var.aws_tg}",
                    "arn:aws:s3:::${var.aws_tg}/*"
                ],
                "Condition": {
                    "Bool": {
                        "aws:SecureTransport": "false"
                    }
                }
            }
        ]
    }
    EOF
}
