terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
      Framework   = local.framework
    }
  }
  alias  = "east"
  region = "us-east-1"
}

provider "aws" {
  default_tags {
    tags = {
      Owner       = local.project
      Environment = local.environment
      Tenant      = local.tenant
      Framework   = local.framework
    }
  }
  alias  = "east-1"
  region = "us-east-2"
}
