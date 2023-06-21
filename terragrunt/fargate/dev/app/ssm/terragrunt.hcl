#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = ".${get_path_to_repo_root()}//modules/ssm"
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
  kms_id      = dependency.kms.outputs.kms_key_id[0]

  key_value = {
    "name"        = include.env.locals.project,
    "environment" = include.env.locals.environment,
    "framework"   = include.env.locals.app.framework
    "api_key"     = include.env.locals.app.api_key
    "hash_key"    = include.env.locals.app.hash_key
  }
}

dependency "kms" {
  config_path = "../../shared/kms"
  mock_outputs = {
    kms_key_id = ["1234abcd-12ab-34cd-56ef-123456789011"]
  }
}
