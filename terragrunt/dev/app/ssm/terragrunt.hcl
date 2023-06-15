#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "../../../../modules/ssm"
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
    "bkc"  = "www.bkc.com",
    "bkc1" = "www.bkc1.com",
    "bkc2" = "www.bkc2.com",
    "bkc3" = "www.bkc3.com"
  }
}

dependency "kms" {
  config_path = "../../kms"
  mock_outputs = {
    kms_key_id = ["1234abcd-12ab-34cd-56ef-123456789011"]
  }
}
