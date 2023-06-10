terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
    template = {
      source = "hashicorp/template"
    }
    random = {
      source = "hashicorp/random"
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
}
