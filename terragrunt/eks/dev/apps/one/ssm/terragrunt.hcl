#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_path_to_repo_root()}//modules/ssm"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}
include "app_env" {
  path   = find_in_parent_folders("app_env.hcl")
  expose = true
}

locals {
  app_name = basename("${dirname(get_terragrunt_dir())}")
}

inputs = {
  project     = include.env.locals.project
  environment = include.env.locals.environment
  kms_id      = dependency.kms.outputs.kms_key_id[0]
  app_name    = basename("${dirname(get_terragrunt_dir())}")

  // PLEASE CHANGE APP1 to appropriate values
  framework = include.app_env.locals.framework // PLEASE CHANGE APP1 to appropriate values

  key_value = {
    "name"        = include.env.locals.project,
    "environment" = include.env.locals.environment,
    "framework"   = include.app_env.locals.framework
    "api_key"     = include.app_env.locals.api_key
    "hash_key"    = include.app_env.locals.hash_key
  }
}

dependency "kms" {
  config_path = "../../../shared/kms"
  mock_outputs = {
    kms_key_id = ["1234abcd-12ab-34cd-56ef-123456789011"]
  }
}
