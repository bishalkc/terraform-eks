# Locals for common
locals {
  project     = "demo-cluster"
  environment = "dev"
  tenant      = "DC"

  bastion = {
    create_public  = true
    create_private = false
    instance_type  = "t3.micro"
    eks_verion     = local.eks.version
  }
  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
    cni_addon = {
      name    = "vpc-cni"
      enable  = true
      version = "v1.12.6-eksbuild.2"
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
