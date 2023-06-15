#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
locals {
  # Automatically load environment-level variables
  # Extract the variables we need for easy access
  aws_region  = "us-east-1"
  bucket_name = "demo-cluster-bucket"
  project     = "demo-cluster"

}
remote_state {
  # Configure S3 as a backend
  backend = "s3"
  config = {
    bucket  = "tf-${local.bucket_name}-${get_aws_account_id()}"
    region  = "us-east-1"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    encrypt = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "aws" {
    region= "${local.aws_region}"
  }
  EOF
}
