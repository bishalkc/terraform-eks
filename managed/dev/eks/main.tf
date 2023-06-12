module "bastion" {
  source = "../../../modules/bastion"

  project                = local.project
  environment            = local.environment
  tenant                 = local.tenant
  bastion_instance_type  = local.bastion.instance_type
  eks_version            = local.bastion.eks_verion
  create_bastion_public  = local.bastion.create_public
  create_bastion_private = local.bastion.create_private
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block         = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  vpc_public_subnet      = data.terraform_remote_state.vpc.outputs.vpc.public[0]
  vpc_private_subnet     = data.terraform_remote_state.vpc.outputs.vpc.private[0]

}

module "kms" {
  source      = "../../../modules/kms"
  project     = local.project
  environment = local.environment
  tenant      = local.tenant
  create_kms  = local.kms.create_kms
}

module "eks" {
  source = "../../../modules/cluster"

  project               = local.project
  environment           = local.environment
  tenant                = local.tenant
  eks_version           = local.eks.version
  eks_instance_type     = local.eks.instance_type
  eks_volume_size       = local.eks.volume_size
  eks_volume_type       = local.eks.volume_type
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr_block        = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  cp_subnet_ids         = data.terraform_remote_state.vpc.outputs.cp
  worker_subnet_ids     = data.terraform_remote_state.vpc.outputs.worker
  kms_key_arn           = data.terraform_remote_state.vpc.outputs.kms_key_arn
  bastion_keypair_name  = data.terraform_remote_state.vpc.outputs.bastion_keypair_name
  bastion_public_sg_id  = data.terraform_remote_state.vpc.outputs.bastion_public_sg_id
  bastion_private_sg_id = data.terraform_remote_state.vpc.outputs.bastion_private_sg_id
  depends_on            = [module.kms, module.bastion]
}

module "addon" {
  source = "../../../modules/addon"

  project      = local.project
  environment  = local.environment
  tenant       = local.tenant
  aws_oidc_url = data.terraform_remote_state.vpc.outputs.oidc_url
  aws_oidc_arn = data.terraform_remote_state.vpc.outputs.oidc_arn
  depends_on   = [module.eks]
}
