#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
// locals {
//   # Automatically load environment-level variables
//   # Extract the variables we need for easy access
//   aws_region  = "us-east-1"
//   project     = "demo-cluster"
//   environment = "dev"
//   tenant      = "DC"
// }
locals {
  // common_deps = "${get_terragrunt_dir()}/${path_relative_from_include()}/env.hcl"
  # Automatically load account-level variables
  env         = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project     = local.env.locals.project
  environment = local.env.locals.environment
  aws_region  = local.env.locals.aws_region
  tenant      = local.env.locals.tenant
  vpc_name    = local.env.locals.vpc.name
}
remote_state {
  # Configure S3 as a backend
  backend = "s3"
  config = {
    bucket  = "tf-${local.vpc_name}-${local.project}-${local.environment}-${get_aws_account_id()}"
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
    default_tags {
      tags = {
        Owner       = "${local.project}"
        Environment = "${local.environment}"
        Tenant      = "${local.tenant}"
      }
    }
  }
  EOF
}
