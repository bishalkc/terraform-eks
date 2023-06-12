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

  # VPC related
  vpc = {
    vpc_id         = var.vpc_id
    vpc_cidr_block = var.vpc_cidr_block

    # Bastion public subnet
    subnet_public  = var.vpc_public_subnet
    subnet_private = var.vpc_private_subnet
    # subnet_private_1_eks_cp_id = data.terraform_remote_state.vpc.outputs.subnet_private_1_eks_cp_id
    # subnet_private_2_eks_cp_id = data.terraform_remote_state.vpc.outputs.subnet_private_2_eks_cp_id

    # subnet_private_1_eks_wrkr_id = data.terraform_remote_state.vpc.outputs.subnet_private_1_eks_wrkr_id
    # subnet_private_2_eks_wrkr_id = data.terraform_remote_state.vpc.outputs.subnet_private_2_eks_wrkr_id

    # APP: Backend IAM Role for Pod Service Account
    # app_backend_iam_oidc_pods_1_arn  = data.terraform_remote_state.app_backend.outputs.iam_oidc_pods_1_arn
  }

  bastion = {
    instance_type  = var.bastion_instance_type
    eks_version    = var.eks_version
    create_private = var.create_bastion_private
    create_public  = var.create_bastion_public
  }
  eks = {
    cluster_name = "${lower(local.project)}-${lower(local.environment)}-eks"
  }
  my_ip = chomp(data.http.myip.response_body)
}
