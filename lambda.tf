# ## Provider block for aws...

# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "4.62.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
#   access_key = "AKIATLW2CW3ICUBA2THA"
#   secret_key = "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"
# }


# ## Archive provider bllock
# provider "archive" {}
# data "archive_file" "zip" {
#   type        = "zip"
#   source_file = "lambdacode.py"
#   output_path = "lambdacode.zip"
# }

# ##Policy document creation 
# data "aws_iam_policy_document" "policy" {
#   statement {
#     sid    = ""
#     effect = "Allow"
#     principals {
#       identifiers = ["lambda.amazonaws.com"]
#       type        = "Service"
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }

# ##iam role for lambda creation
# resource "aws_iam_role" "lambda_iamrole" {
#   name               = "lambda_iamrole"
#   assume_role_policy = data.aws_iam_policy_document.policy.json
# }

# ## Lambda function creation
# resource "aws_lambda_function" "lambdafn" {
#   function_name = "lambda_test"
#   filename         = data.archive_file.zip.output_path
#   source_code_hash = data.archive_file.zip.output_base64sha256
#   role    = aws_iam_role.lambda_iamrole.arn
#   handler = "lambdacode.lambda_handler"
#   runtime = "python3.9"
# }