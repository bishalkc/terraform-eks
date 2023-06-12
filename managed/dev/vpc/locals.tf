data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  #ACCOUNT CONFIG
  project     = "demo-cluster"
  environment = "dev"
  tenant      = "DC"
  aws_region  = data.aws_region.current.name
  account_id  = data.aws_caller_identity.current.account_id
}
