#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "../../../../modules/addon"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

inputs = {
  project     = include.env.locals.project
  environment = include.env.locals.environment

  # ADDON
  enable_cni = include.env.locals.eks.cni_addon.enable
  enable_ebs = include.env.locals.eks.ebs_addon.enable

  # OIDC Values
  aws_oidc_url = dependency.eks.outputs.oidc_url
  aws_oidc_arn = dependency.eks.outputs.oidc_arn

  # VPC
  eks_cluster_name = dependency.eks.outputs.eks_cluster_name

}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    oidc_url         = "https://oidc.eks-us-east-1.amazonaws.com/id/169841B48D5B8A662A4C7AOE2B101423"
    oidc_arn         = "arn:aws:eks-us-east-1:${get_aws_account_id()}:cluster/oidc-demo"
    eks_cluster_name = "demo-cluster-name"
  }
}
