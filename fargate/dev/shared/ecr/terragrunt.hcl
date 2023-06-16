#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../../modules/ecr"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

inputs = {
  project     = include.env.locals.project
  environment = include.env.locals.environment
  create_ecr  = include.env.locals.create.ecr
}
