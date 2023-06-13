
module "vpc" {
  source = "../../../modules/vpc"

  providers = {
    aws = aws.east
  }

  project              = local.project
  environment          = local.environment
  tenant               = local.tenant
  base_cidr            = var.base_cidr
  az_count             = var.az_count
  availability_zones   = var.availability_zones
  public_subnet_cidr   = var.public_subnet_cidr
  cp_subnet_cidr       = var.cp_subnet_cidr
  svcs_subnet_cidr     = var.svcs_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr
  worker_subnet_cidr   = var.worker_subnet_cidr

}
