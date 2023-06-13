# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  project        = "demo-cluster"
  environment    = "dev"
  tenant         = "DC"
  framework      = "drupal"
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id

  db = {
    type          = "mariadb"
    version       = "10.5.0"
    port          = 3306
    instance_type = "db.t3.medium"
  }
  create = {
    ssm             = true
    secret_database = true
  }
}
