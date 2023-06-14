module "eks" {

  providers = {
    aws = aws.default
  }

  source = "../../../modules/eks"

  # Default Values
  project     = local.project
  environment = local.environment

  # EKS Values
  eks_version       = local.eks.version
  eks_instance_type = local.eks.instance_type
  eks_volume_size   = local.eks.volume_size
  eks_volume_type   = local.eks.volume_type

  # VPC Values
  cp_subnet_ids      = data.terraform_remote_state.vpc.outputs.cp
  worker_subnet_ids  = data.terraform_remote_state.vpc.outputs.worker
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_public_subnet  = data.terraform_remote_state.vpc.outputs.public[0]
  vpc_private_subnet = data.terraform_remote_state.vpc.outputs.svcs[0]

  # KMS Key ARN
  kms_key_arn = data.terraform_remote_state.shared.outputs.kms_alias_arn[0]

  # Bastion Values
  bastion_instance_type  = local.bastion.instance_type
  create_public_bastion  = local.bastion.create_public
  create_private_bastion = local.bastion.create_private

  # Enable LB Controller
  eks_cluster_name = local.eks.cluster_name
}
