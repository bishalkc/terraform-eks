# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "tls_certificate" "oidc" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

locals {
  project        = "demo-cluster"
  environment    = "dev"
  tenant         = "DC"
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id

  # VPC related
  vpc_id         = data.terraform_remote_state.common.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.common.outputs.vpc_cidr_block


  # Bastion public subnet
  subnet_public = data.terraform_remote_state.common.outputs.public[0]
  # subnet_private_1_eks_cp_id = data.terraform_remote_state.common.outputs.subnet_private_1_eks_cp_id
  # subnet_private_2_eks_cp_id = data.terraform_remote_state.common.outputs.subnet_private_2_eks_cp_id


  # subnet_private_1_eks_wrkr_id = data.terraform_remote_state.common.outputs.subnet_private_1_eks_wrkr_id
  # subnet_private_2_eks_wrkr_id = data.terraform_remote_state.common.outputs.subnet_private_2_eks_wrkr_id

  # APP: Backend IAM Role for Pod Service Account
  # app_backend_iam_oidc_pods_1_arn  = data.terraform_remote_state.app_backend.outputs.iam_oidc_pods_1_arn
  bastion = {
    instance_type = "t3.micro"
  }
  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
    cni_addon = {
      version = "v1.12.6-eksbuild.2"
      name    = "vpc-cni"
    }
    ebs_addon = {
      name    = "aws-ebs-csi-driver"
      version = "v1.19.0-eksbuild.2"
    }
    version       = "1.27"
    instance_type = "t3.micro"
    volume_size   = 20
    volume_type   = "gp3"
  }
  type = {
    fargate = false
    managed = true
  }

}
