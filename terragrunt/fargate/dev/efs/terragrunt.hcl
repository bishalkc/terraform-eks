#------------------------------------------------------
# TERRAFORM STATE
#------------------------------------------------------
terraform {
  source = "../../../../modules/efs"
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
  eks_security_group_id = dependency.eks.outputs.eks_security_group_id
  worker_subnet_ids     = dependency.vpc.outputs.worker
  create_efs            = include.env.locals.create.efs
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
