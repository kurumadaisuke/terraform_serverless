############ DynamoDBユーザー情報管理 ############
resource "aws_dynamodb_table" "user-table" {
  name           = "user-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Id"

  attribute {
    name = "Id"
    type = "N"
  }

  tags = {
    Name    = "${var.project}-${var.environment}-user-table"
    Project = var.project
    Env     = var.environment
    }
}

resource "aws_dynamodb_table_item" "user-table-item" {
  table_name = aws_dynamodb_table.user-table.name
  hash_key   = aws_dynamodb_table.user-table.hash_key

  item = <<ITEM
{
  "Id": {"N": "1"}
}
ITEM
}

############ DynamoDB id連番管理 ############
resource "aws_dynamodb_table" "sequence-table" {
  name           = "sequence-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "tablename"

  attribute {
    name = "tablename"
    type = "S"
  }
  
  tags = {
    Name    = "${var.project}-${var.environment}-sequence-table"
    Project = var.project
    Env     = var.environment
    }
}

resource "aws_dynamodb_table_item" "sequence-table-item" {
  table_name = aws_dynamodb_table.sequence-table.name
  hash_key   = aws_dynamodb_table.sequence-table.hash_key

  item = <<ITEM
{
  "tablename": {"S": "user"},
  "seq": {"N": "0"}
}
ITEM
}