resource "aws_lambda_function" "log_collection_lambda"{
    filename      = "./log_coll_lambda.zip"
    function_name = var.aws_ld
    role          = aws_iam_role.role.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.9"
    depends_on = [aws_s3_bucket.log-collection-bucket]
}
