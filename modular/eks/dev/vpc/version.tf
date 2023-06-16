terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0"
    }
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.3.0"
      configuration_aliases = [aws.default, aws.ohio]
    }
  }
}
provider "aws" {
  default_tags {
    tags = {
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
    }
  }
  alias  = "default"
  region = "us-east-1"
}

provider "aws" {
  default_tags {
    tags = {
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
    }
  }
  alias  = "ohio"
  region = "us-east-2"
}
