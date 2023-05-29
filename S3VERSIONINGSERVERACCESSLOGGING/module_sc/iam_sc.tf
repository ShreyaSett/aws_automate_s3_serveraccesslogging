data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = var.aws_rolename
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.role.name
}

resource "aws_iam_policy" "add_policy"{
    name        = "s3_policy"
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "s3:GetObject",
                    "s3:PutBucketLogging",
                    "s3:GetBucketLogging",
                    "s3:PutBucketPolicy",
                    "s3:CreateBucket",
                    "s3:PutObject",
                    "s3:ListBucket",
                    "s3:GetBucketVersioning",
                    "s3:GetBucketLocation",
                    "s3:GetBucketPolicy",
                    "s3:PutBucketVersioning",
                    "s3:PutObjectAcl",
                    "s3:GetObjectVersion"
                ],
                "Resource": "*"
            }
        ]
    })
    tags = {
        Notes = "Created for providing Lambda read and write permissions on the s3 buckets"
    }
}

resource "aws_iam_role_policy_attachment" "additional" {
    policy_arn = aws_iam_policy.add_policy.arn
    role       = aws_iam_role.role.name
}
