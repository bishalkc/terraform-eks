terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
  }
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

# module "vpc" {
#   source = "../../../modules/vpc"
# }
# module "cluster" {
#   source = "../../../modules/cluster"
# }
# module "bastion" {
#   source = "../../../modules/bastion"
# }
# module "addon" {
#   source = "../../../modules/addon"
# }
# module "ecr" {
#   source = "../../../modules/ecr"
# }
# module "kms" {
#   source = "../../../modules/kms"
# }
# module "database" {
#   source = "../../../modules/database"
# }
