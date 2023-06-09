## Set up main terraform backend
terraform {
  backend "s3" {
    bucket  = "tetra-tech-terraform-state"
    key     = "infrastructure/dev/app.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}


## Utilize "common" remote state resources
data "terraform_remote_state" "common" {
  backend = "s3"

  config = {
    bucket  = "tetra-tech-terraform-state"
    key     = "infrastructure/dev/common.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}

## Utilize "eks" remote state resources
data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket  = "tetra-tech-terraform-state"
    key     = "infrastructure/dev/eks.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}
