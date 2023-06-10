resource "aws_eks_cluster" "eks" {
  name                      = local.eks.cluster_name
  version                   = local.eks.version
  role_arn                  = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  vpc_config {
    subnet_ids              = concat(data.terraform_remote_state.common.outputs.public, data.terraform_remote_state.common.outputs.svcs, data.terraform_remote_state.common.outputs.database, data.terraform_remote_state.common.outputs.cp, data.terraform_remote_state.common.outputs.worker)
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["${data.url}/32"] # Bishal.KC
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.kms.arn
    }
  }

  timeouts {
    create = "30m"
    update = "60m"
    delete = "15m"
  }

  tags = {
    Name     = "eks-cluster-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "eks"
  }

}
