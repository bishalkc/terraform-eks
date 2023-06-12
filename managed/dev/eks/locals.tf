# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  project        = "demo-cluster"
  environment    = "dev"
  tenant         = "DC"
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id
  my_ip          = chomp(data.http.myip.response_body)

  bastion = {
    create_public  = true
    create_private = false
    instance_type  = "t3.micro"
    eks_verion     = local.eks.version
  }
  kms = {
    create_kms = true
  }
  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
    cni_addon = {
      enable  = true
      version = "v1.12.6-eksbuild.2"
      name    = "vpc-cni"
    }
    ebs_addon = {
      name    = "aws-ebs-csi-driver"
      version = "v1.19.0-eksbuild.2"
      enable  = true
    }
    version       = "1.27"
    instance_type = "t3.medium"
    volume_size   = 20
    volume_type   = "gp3"
  }
}
