terraform {
  required_version = ">= 1.0.0"
}
provider "aws" {
  version = "5.2.0"

  default_tags {
    tags = {
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
    }
  }
}
