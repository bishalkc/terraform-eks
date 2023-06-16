rule "aws_resource_missing_tags" {
  enabled = true
  tags = [
    "owner",
    "environment",
    "tenant",
  ]
}
