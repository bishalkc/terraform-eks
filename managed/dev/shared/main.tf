module "kms" {

  providers = {
    aws = aws.east
  }

  source = "../../../modules/kms"

  project     = local.project
  environment = local.environment
  tenant      = local.tenant
  create_kms  = local.create.kms
}

module "ecr" {

  providers = {
    aws = aws.east
  }
  source = "../../../modules/ecr"

  project     = local.project
  environment = local.environment
  tenant      = local.tenant
  create_ecr  = local.create.ecr
}
