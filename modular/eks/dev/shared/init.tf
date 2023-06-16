terraform {
  backend "s3" {
    bucket  = "demo-cluster-terraform-state"
    key     = "infrastructure/dev/shared.json"
    encrypt = "true"
    region  = "us-east-1"
  }
}
