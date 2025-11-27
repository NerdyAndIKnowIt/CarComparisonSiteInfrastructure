resource "aws_dynamodb_table" "thatvsthis_table" {
  name         = "ThatVsThisTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Make"
  range_key    = "Model"

  attribute {
    name = "Make"
    type = "S"
  }

  attribute {
    name = "Model"
    type = "S"
  }
}