# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  project        = "demo-cluster"
  environment    = "dev"
  tenant         = "DC"
  framework      = "drupal"
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id

  //VPC related
  vpc_id         = data.terraform_remote_state.common.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.common.outputs.vpc_cidr_block
  
    // Security Groups related
  sg_bastion_public_id = data.terraform_remote_state.eks.outputs.sg_bastion_public_id
  sg_bastion_private_id = data.terraform_remote_state.eks.outputs.sg_bastion_private_id

  db = {
    type = "mariadb"
    version = "10.5.0"
    port = 3306
    instance_type = "db.t3.medium"
  }

}
