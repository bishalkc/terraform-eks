module "secretmanager" {
  source = "../../../../modules/secretmanager"
  providers = {
    aws = aws.default
  }
  project     = local.project
  environment = local.environment
  kms_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
  suffix      = "v1"

  secret_string = {
    "user"     = "bkc",
    "password" = "value"
    "host"     = "blah"
  }
}

module "ssm" {
  source = "../../../../modules/ssm"
  providers = {
    aws = aws.default
  }
  project     = local.project
  environment = local.environment
  framework   = local.framework
  kms_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
  key_value = {
    "name"        = local.project,
    "environment" = local.environment,
    "framework"   = local.framework,
    "api_key"     = "afdadf-adfadsf-aa45adf-adfadsf",
    "hash_key"    = "adfadfa00i--9i-3q20"
  }
}
