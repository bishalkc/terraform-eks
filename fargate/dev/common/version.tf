terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
  }
}
provider "aws" {
  default_tags {
    tags = {
      Owner                                                             = local.project
      Environment                                                       = local.environment
      Tenant                                                            = local.tenant
      "kubernetes.io/cluster/${local.project}-${local.environment}-eks" = "shared"
    }
  }
}
