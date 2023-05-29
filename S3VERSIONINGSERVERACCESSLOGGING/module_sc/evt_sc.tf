resource "aws_cloudwatch_event_rule" "logcollrule" {
    name        = var.aws_eventrule
    description = "Rule for triggering lambda function for s3 versioning and sever access log collection"
    event_pattern = <<EOF
    {
        "source": ["aws.s3"],
        "detail-type": ["AWS API Call via CloudTrail"],
        "detail": {
            "eventSource": ["s3.amazonaws.com"],
            "eventName": ["CreateBucket"]
        }
    }
    EOF
}

resource "aws_cloudwatch_event_target" "log_lambda"{
    rule = aws_cloudwatch_event_rule.logcollrule.name
    target_id = "log_coll"
    arn = aws_lambda_function.log_collection_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
    statement_id = "AllowExecutionFromEventbridgeTrigger"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.log_collection_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.logcollrule.arn
}

