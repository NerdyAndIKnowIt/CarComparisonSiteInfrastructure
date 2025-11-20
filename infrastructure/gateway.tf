resource "aws_apigatewayv2_api" "thatvsthis_api" {
  name          = "ThatVsThisAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.thatvsthis_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.thatvsthis_lambda.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_stage" "prod_stage" {
  api_id      = aws_apigatewayv2_api.thatvsthis_api.id
  name        = "prod"
  auto_deploy = true
}