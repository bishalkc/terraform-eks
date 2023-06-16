#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "../../../modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

inputs = {
  #Default
  project     = include.env.locals.project
  environment = include.env.locals.environment

  # EKS Values
  eks_cluster_name  = include.env.locals.eks.cluster_name
  eks_version       = include.env.locals.eks.version
  eks_instance_type = include.env.locals.eks.instance_type
  eks_volume_size   = include.env.locals.eks.volume_size
  eks_volume_type   = include.env.locals.eks.volume_type
  is_fargate        = dependency.vpc.outputs.is_fargate

  # VPC Values
  cp_subnet_ids      = dependency.vpc.outputs.cp
  worker_subnet_ids  = dependency.vpc.outputs.worker
  vpc_id             = dependency.vpc.outputs.vpc_id
  vpc_public_subnet  = dependency.vpc.outputs.public[0]
  vpc_private_subnet = dependency.vpc.outputs.svcs[0]

  # KMS Key ARN
  kms_key_arn = dependency.kms.outputs.kms_key_arn[0]

  # Bastion Values
  bastion_instance_type  = include.env.locals.bastion.instance_type
  create_public_bastion  = include.env.locals.bastion.create_public
  create_private_bastion = include.env.locals.bastion.create_private
}


dependency "vpc" {
  config_path = "../vpc"

  mock_outputs_merge_with_state = true

  mock_outputs = {
    cp         = ["cp-subnet-123", "cp-subnet-456"]
    worker     = ["worker-subnet-123", "worker-subnet-456"]
    vpc_id     = "cp-subnet-456"
    public     = ["vpc-private-subnet-123"]
    svcs       = ["vpc-public-subnet-123"]
    is_fargate = false
  }
}

dependency "kms" {
  config_path = "../shared/kms"

  mock_outputs = {
    kms_key_arn = ["arn:aws:kms:us-east-1:${get_aws_account_id()}:key/1234abcd-12ab-34cd-56ef-123456789011"]

  }
}
