terraform {
  required_version = ">= 1.0.0"
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.21.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.1.0"
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

# provider "kubernetes" {
#   host                   = module.eks.eks_cluster_name
#   cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca_certificate)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", module.eks.eks_cluster_name]
#     command     = "aws"
#   }
# }
