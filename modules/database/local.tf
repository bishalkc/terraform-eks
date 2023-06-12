# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  project         = var.project
  environment     = var.environment
  tenant          = var.tenant
  aws_region      = data.aws_region.current.name
  account_id      = data.aws_caller_identity.current.account_id
  account_number  = data.aws_caller_identity.current.account_id
  create_database = var.create_database

  # VPC related
  vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  # Security Groups related
  sg_bastion_public_id  = data.terraform_remote_state.eks.outputs.sg_bastion_public_id
  sg_bastion_private_id = data.terraform_remote_state.eks.outputs.sg_bastion_private_id

  db = {
    type          = var.db_type
    version       = var.db_version
    port          = var.db_port
    instance_type = var.db_instance_type
  }
}
