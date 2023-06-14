terraform {
  backend "s3" {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/eks.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}

## Utilize "vpc" remote state resources
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/vpc.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}

## Utilize "vpc" remote state resources
data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/shared.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}
