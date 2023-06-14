module "vpc" {
  source = "../../../modules/vpc"

  providers = {
    aws = aws.default
  }

  project            = local.project
  environment        = local.environment
  base_cidr          = var.base_cidr
  az_count           = var.az_count
  availability_zones = var.availability_zones

}
