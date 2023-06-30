# Locals for common
data "aws_caller_identity" "current" {}

locals {
  account_number = data.aws_caller_identity.current.account_id
}
