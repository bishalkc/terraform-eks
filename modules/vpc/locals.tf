data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  #ACCOUNT CONFIG
  project     = var.project
  environment = var.environment
  tenant      = var.tenant
  aws_region  = data.aws_region.current.name
  account_id  = data.aws_caller_identity.current.account_id
}
