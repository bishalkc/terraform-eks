locals {
  #------------------------------------------------------
  # GLOBAL VARIABLES
  #------------------------------------------------------
  project     = "demo-cluster"
  environment = "dev"
  tenant      = "DC"
  #------------------------------------------------------
  # VPC VARIABLES
  #------------------------------------------------------
  base_cidr          = "10.100.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  az_count           = 3

  #------------------------------------------------------
  # Shared Services [ECR/KMS] VARIABLES
  #------------------------------------------------------
  create = {
    ecr = true
    kms = true
    // efs = true require for fargate cluster, default is false
  }

  #------------------------------------------------------
  # EKS AND BASTION VARIABLES
  #------------------------------------------------------
  bastion = {
    create_public  = true
    create_private = false
    instance_type  = "t3.micro"
  }
  eks = {
    cluster_name = "${local.project}-${local.environment}-eks"
    cni_addon = {
      name    = "vpc-cni"
      enable  = true
      version = "v1.12.6-eksbuild.2"
    }
    ebs_addon = {
      name    = "aws-ebs-csi-driver"
      version = "v1.19.0-eksbuild.2"
      enable  = true
    }
    enable_lb_controller = true
    version              = "1.27"
    instance_type        = "t3.medium"
    volume_size          = 20
    volume_type          = "gp3"
  }

  #------------------------------------------------------
  # APP VARIABLES
  #------------------------------------------------------
  app = {
    framework = "drupal"
    api_key   = "6464-464adfasd-164afdd-64fdad"
    hash_key  = "ADFADF465643SAFTWAF"
  }
}
