## Set up main terraform backend
terraform {
  backend "s3" {
    bucket  = "tetra-tech-terraform-state"
    key     = "infrastructure/dev/app.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}


# ## Utilize "vpc" remote state resources
# data "terraform_remote_state" "vpc" {
#   backend = "s3"

#   config = {
#     bucket  = "tetra-tech-terraform-state"
#     key     = "infrastructure/dev/vpc.json"
#     encrypt = "true"
#     region  = "us-east-1"
#   }
# }

## Utilize "vpc" remote state resources
data "terraform_remote_state" "shared" {
  backend = "s3"

  config = {
    bucket  = "tetra-tech-terraform-state"
    key     = "infrastructure/dev/shared.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}
