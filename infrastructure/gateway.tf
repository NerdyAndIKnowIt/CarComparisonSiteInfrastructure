resource "aws_apigatewayv2_api" "thatvsthis_api" {
  name          = "ThatVsThisAPI"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "OPTIONS"]
    allow_headers = ["Content-Type"]
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.thatvsthis_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.thatvsthis_lambda.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.thatvsthis_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.thatvsthis_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_stage" "prod_stage" {
  api_id      = aws_apigatewayv2_api.thatvsthis_api.id
  name        = "prod"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "get_cars" {
  api_id    = aws_apigatewayv2_api.thatvsthis_api.id
  route_key = "GET /cars"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_route" "get_car_make" {
  api_id    = aws_apigatewayv2_api.thatvsthis_api.id
  route_key = "GET /cars/{make}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_route" "get_car_model" {
  api_id    = aws_apigatewayv2_api.thatvsthis_api.id
  route_key = "GET /cars/{make}/{model}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}