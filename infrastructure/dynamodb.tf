resource "aws_dynamodb_table" "thatvsthis_table" {
  name         = "ThatVsThisTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "make"
  range_key    = "model"

  attribute {
    name = "make"
    type = "S"
  }

  attribute {
    name = "model"
    type = "S"
  }
}