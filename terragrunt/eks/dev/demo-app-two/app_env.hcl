#------------------------------------------------------
# APP VARIABLES
#------------------------------------------------------

locals {
  framework = "drupal"
  api_key   = "6464-464adfasd-164afdd-6345345"
  hash_key  = "DASFADSF3EREWQWER-ADFADF-F465643SAFTWAF"
  secret = {
    create  = true
    name    = "secrets"
    version = "v1"
  }
  ssm = {
    create = true
  }
}
