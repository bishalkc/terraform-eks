#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_path_to_repo_root()}//modules/secretmanager"
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
  prefix      = "v1"
  secret_string = {
    "user"     = "demo-cluster-user",
    "password" = "demo-cluster-password"
    "host"     = "demo-cluster-host"
    "dbname"   = "demo-cluster-dbname"
  }
}

dependency "kms" {
  config_path = "../../shared/kms"

  mock_outputs = {
    kms_key_id = ["1234abcd-12ab-34cd-56ef-123456789011"]
  }
}
