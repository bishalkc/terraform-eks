#------------------------------------------------------
# APP VARIABLES
#------------------------------------------------------
locals {
  framework = "python"
  api_key   = "6464-464adfasd-164afdd-64fdad"
  hash_key  = "ADFADF465643SAFTWAF"
  secret = {
    create  = true
    name    = "secrets"
    version = "v1"
  }
  ssm = {
    create = true
  }
}
