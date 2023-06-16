terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.1.0"
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

