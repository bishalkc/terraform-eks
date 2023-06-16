# Locals for common

locals {
  project     = "demo-cluster"
  environment = "dev"
  tenant      = "DC"

  create = {
    kms = true
    ecr = true
  }
}
