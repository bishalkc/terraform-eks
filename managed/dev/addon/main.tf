module "addon" {

  providers = {
    aws = aws.default
  }

  source = "../../../modules/addon"

  project     = local.project
  environment = local.environment

  # ADDON
  enable_cni = local.eks.cni_addon.enable
  enable_ebs = local.eks.ebs_addon.enable

  # OIDC Values
  aws_oidc_url = data.terraform_remote_state.eks.outputs.oidc_url
  aws_oidc_arn = data.terraform_remote_state.eks.outputs.oidc_arn

  # VPC
  eks_cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

module "lbcontroller" {

  providers = {
    aws = aws.default
  }

  source = "../../../modules/lbcontroller"

  project     = local.project
  environment = local.environment

  # ADDON
  enable_lb_controller = local.eks.enable_lb_controller

  # OIDC Values
  aws_oidc_url = data.terraform_remote_state.eks.outputs.oidc_url
  aws_oidc_arn = data.terraform_remote_state.eks.outputs.oidc_arn

  # VPC
  eks_cluster_name           = data.terraform_remote_state.eks.outputs.eks_cluster_name
  eks_cluster_ca_certificate = data.terraform_remote_state.eks.outputs.eks_cluster_ca_certificate
  eks_cluster_endpoint       = data.terraform_remote_state.eks.outputs.eks_cluster_endpoint
}
