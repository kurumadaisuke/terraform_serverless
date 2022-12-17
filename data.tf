data "aws_prefix_list" "dynamodb_pl" {
  name = "com.amazonaws.*.dynamodb"
}