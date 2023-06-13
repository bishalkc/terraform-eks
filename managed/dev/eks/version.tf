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
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_name
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
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
