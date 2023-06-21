#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "${get_path_to_repo_root()}//modules/efs"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

inputs = {
  project               = include.env.locals.project
  environment           = include.env.locals.environment
  framework             = include.env.locals.framework
  eks_security_group_id = dependency.eks.outputs.eks_security_group_id
  worker_subnet_ids     = dependency.vpc.outputs.worker
  create_efs            = include.env.locals.create.efs
  kms_id                = dependency.kms.outputs.kms_key_id[0]
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    eks_security_group_id = "sg-dafad39098adsf08"
  }
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    cp         = ["cp-subnet-123", "cp-subnet-456", "cp-subnet-789"]
    worker     = ["worker-subnet-123", "worker-subnet-456", "worker-subnet-789"]
    vpc_id     = "mock-vpc-ie-456"
    public     = ["vpc-private-subnet-123"]
    svcs       = ["vpc-public-subnet-123"]
    is_fargate = true
  }
}

dependency "kms" {
  config_path = "../shared/kms"
  mock_outputs = {
    kms_key_id = ["1234abcd-12ab-34cd-56ef-123456789011"]
  }
}
