#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_path_to_repo_root()}//modules/vpc"
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
  base_cidr          = include.env.locals.vpc.base_cidr
  az_count           = include.env.locals.vpc.az_count
  availability_zones = include.env.locals.vpc.availability_zones
  vpc_name           = include.env.locals.vpc.name
}
