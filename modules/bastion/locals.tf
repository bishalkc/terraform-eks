# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_ami" "bastion_amazon_linux_2_latest" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  project        = var.project
  environment    = var.environment
  tenant         = var.tenant
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id

  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
  }
  my_ip = chomp(data.http.myip.response_body)
}
