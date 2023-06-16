#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

inputs = {
  project            = include.env.locals.project
  environment        = include.env.locals.environment
  base_cidr          = include.env.locals.base_cidr
  az_count           = include.env.locals.az_count
  availability_zones = include.env.locals.availability_zones
  is_fargate         = true
}
