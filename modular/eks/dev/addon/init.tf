terraform {
  backend "s3" {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/addon.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}

## Utilize "eks" remote state resources
data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/eks.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}
