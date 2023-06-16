module "kms" {

  providers = {
    aws = aws.default
  }

  source = "../../../../modules/kms"

  project     = local.project
  environment = local.environment
  create_kms  = local.create.kms
}

module "ecr" {

  providers = {
    aws = aws.default
  }

  source = "../../../../modules/ecr"

  project     = local.project
  environment = local.environment
  create_ecr  = local.create.ecr
}
