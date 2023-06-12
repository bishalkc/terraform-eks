# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  project        = var.project
  environment    = var.environment
  tenant         = var.tenant
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id

  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
    cni_addon = {
      version = var.cni_addon_version
      name    = var.cni_addon_name
      enabled = var.enable_cni
    }
    ebs_addon = {
      name    = var.ebs_addon_name
      version = var.ebs_addon_version
      enabled = var.enable_ebs
    }
    oidc = {
      url = var.aws_oidc_url
      arn = var.aws_oidc_arn
    }
  }
}
