terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    tls = {
      source = "hashicorp/tls"
    }
    http = {
      source = "hashicorp/http"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}
