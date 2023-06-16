#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "../../../../modules/kms"
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
  create_kms  = include.env.locals.create.kms
}
