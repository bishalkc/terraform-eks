module "bastion" {
  source = "../../../modules/bastion"

  providers = {
    aws = aws.east
  }

  project                = local.project
  environment            = local.environment
  bastion_instance_type  = local.bastion.instance_type
  eks_version            = local.bastion.eks_verion
  eks_cluster_name       = local.eks.cluster_name
  create_public_bastion  = local.bastion.create_public
  create_private_bastion = local.bastion.create_private
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_public_subnet      = data.terraform_remote_state.vpc.outputs.public[0]
  vpc_private_subnet     = data.terraform_remote_state.vpc.outputs.svcs[0]

}

module "eks" {
  source = "../../../modules/eks"
  providers = {
    aws        = aws.east
    kubernetes = kubernetes
    http       = http
    tls        = tls
  }
  # Default Values
  project     = local.project
  environment = local.environment

  # EKS Values
  eks_version       = local.eks.version
  eks_instance_type = local.eks.instance_type
  eks_volume_size   = local.eks.volume_size
  eks_volume_type   = local.eks.volume_type

  # VPC Values
  cp_subnet_ids     = data.terraform_remote_state.vpc.outputs.cp
  worker_subnet_ids = data.terraform_remote_state.vpc.outputs.worker

  # KMS Key ARN
  kms_key_arn = data.terraform_remote_state.shared.outputs.kms_alias_arn

  # Bastion Values
  bastion_keypair_name  = module.bastion.bastion_keypair_name
  bastion_public_sg_id  = local.bastion.create_public == true ? module.bastion.bastion_public_sg_id[0] : "null"
  bastion_private_sg_id = local.bastion.create_private == true ? module.bastion.bastion_private_sg_id[0] : "null"

  # Enable LB Controller
  eks_lb_controller = true
  eks_cluster_name  = local.eks.cluster_name
}

module "addon" {
  source = "../../../modules/addon"

  project     = local.project
  environment = local.environment

  # ADDON
  enable_cni = local.eks.cni_addon.enable
  enable_ebs = local.eks.ebs_addon.enable

  # OIDC Values
  aws_oidc_url = module.eks.oidc_url
  aws_oidc_arn = module.eks.oidc_arn

  # VPC
  eks_cluster_name = module.eks.eks_cluster_name
}
