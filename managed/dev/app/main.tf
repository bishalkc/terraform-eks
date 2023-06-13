module "secretmanager" {
  source = "../../../modules/secretmanager"
  providers = {
    aws = aws.default
  }
  project     = local.project
  environment = local.environment
  tenant      = local.tenant
  kms_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
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
  for_each = {
    "bkc"  = "www.bkc.com",
    "bkc1" = "www.bkc1.com",
    "bkc2" = "www.bkc2.com",
    "bkc3" = "www.bkc3.com"
  }
  project     = local.project
  environment = local.environment
  tenant      = local.tenant
  framework   = local.framework
  key_id      = data.terraform_remote_state.shared.outputs.kms_key_id[0]
  name        = each.key
  value       = each.value
}
