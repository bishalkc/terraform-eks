module "secretmanager" {
  source = "../../../modules/secretmanager"
  providers = {
    aws = aws.default
  }
  project     = local.project
  environment = local.environment
  kms_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
  prefix      = "v1"

  secret_string = {
    "user"     = "bkc",
    "password" = "value"
    "host"     = "blah"
  }
}

module "ssm" {
  source = "../../../modules/ssm"
  providers = {
    aws = aws.default
  }
  project     = local.project
  environment = local.environment
  framework   = local.framework
  kms_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
  key_value = {
    "bkc"  = "www.bkc.com",
    "bkc1" = "www.bkc1.com",
    "bkc2" = "www.bkc2.com",
    "bkc3" = "www.bkc3.com"
  }
}
