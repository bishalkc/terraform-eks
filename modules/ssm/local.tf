# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {

  project        = var.project
  environment    = var.environment
  tenant         = var.tenant
  framework      = var.framework
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id
  ssm = {
    database = var.create_secret_database
    app      = var.create_secret_app
  }

}
