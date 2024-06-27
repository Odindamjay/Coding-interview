resource "aws_instance" "sre_test" {
  ami = "ami-0c55b1b59"
  instance_type = var.instance_type
  tags = {
    Name = "SREInstance"
  }
}
resource "aws_sns_topic" "sre_topic" {
  name = var.sns_topic_name
}
resource "aws_iam_role" "sre_iam_lambda" {
  name               = "sre_iam_lambda"
  assume_role_policy =  jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        },
    ]
  })

}
resource "aws_iam_policy" "sre_lambda_logging" {
  name        = "sre_lambda_logging"
  description = "IAM policy for logging from a lambda"
  policy      =  jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = ["logs:*", "ec2:RebootInstances", "sns:Publish"],
            Effect = "Allow"
            Resource = "*"
        },
    ]
  })
}
resource "aws_lambda_function" "sre_lambda" {
    function_name = "RestartEc2Instance"
    handler = "lambda_function.lambda_handler"
    role = aws_iam_role.sre_iam_lambda.arn
    runtime = "python3.8"

    filename = "function.zip"

    environment {
      variables = {
        INSTANCE_ID = aws_instance.sre_test.id
        SNS_TOPIC_ARN = aws_sns_topic.sre_topic.arn
        AWS_REGION = var.region
      }
    }
}
