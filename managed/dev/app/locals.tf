# Locals for common

data "aws_caller_identity" "current" {}

locals {
  project        = "demo-cluster"
  environment    = "dev"
  tenant         = "DC"
  framework      = "drupal"
  account_number = data.aws_caller_identity.current.account_id

  db = {
    type          = "mariadb"
    version       = "10.5.0"
    port          = 3306
    instance_type = "db.t3.medium"
  }

}
