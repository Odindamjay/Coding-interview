output "ec2_instance_id" {
  value = aws_instance.sre_test.id
}

output "lambda_function_arn" {
  value = aws_lambda_function.sre_lambda.arn
}

output "sns_topic_arn" {
  value = aws_sns_topic.sre_topic.arn
}
