# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "tls_certificate" "oidc" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  project        = var.project
  environment    = var.environment
  tenant         = var.tenant
  aws_region     = data.aws_region.current.name
  account_id     = data.aws_caller_identity.current.account_id
  account_number = data.aws_caller_identity.current.account_id
  # VPC related
  vpc = {
    vpc_id            = var.vpc_id
    vpc_cidr_block    = var.vpc_cidr_block
    cp_subnet_ids     = var.cp_subnet_ids
    worker_subnet_ids = var.worker_subnet_ids
    # Bastion public subnet
    # subnet_public = var.vpc_public_subnet
    # subnet_private_1_eks_cp_id = data.terraform_remote_state.vpc.outputs.subnet_private_1_eks_cp_id
    # subnet_private_2_eks_cp_id = data.terraform_remote_state.vpc.outputs.subnet_private_2_eks_cp_id

    # subnet_private_1_eks_wrkr_id = data.terraform_remote_state.vpc.outputs.subnet_private_1_eks_wrkr_id
    # subnet_private_2_eks_wrkr_id = data.terraform_remote_state.vpc.outputs.subnet_private_2_eks_wrkr_id

    # APP: Backend IAM Role for Pod Service Account
    # app_backend_iam_oidc_pods_1_arn  = data.terraform_remote_state.app_backend.outputs.iam_oidc_pods_1_arn
  }
  bastion = {
    instance_type = "t3.micro"
    keypair_name  = var.bastion_keypair_name
    public_sg_id  = var.bastion_public_sg_id
    private_sg_id = var.bastion_public_sg_id
  }
  eks = {
    cluster_name  = "${lower(local.project)}-${lower(local.environment)}-eks"
    version       = var.eks_version
    instance_type = var.eks_instance_type
    volume_size   = var.eks_volume_size
    volume_type   = var.eks_volume_type
    lb_controller = var.lb_controller
  }
  kms = {
    kms_key_arn = var.kms_key_arn
  }
  my_ip = chomp(data.http.myip.response_body)
}
