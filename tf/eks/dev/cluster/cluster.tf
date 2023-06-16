provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
  load_config_file       = false
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks.id
}


resource "aws_eks_cluster" "eks" {
  name                      = local.eks.cluster_name
  version                   = local.eks.version
  role_arn                  = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  vpc_config {
    subnet_ids              = data.terraform_remote_state.common.outputs.cp
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["${local.my_ip}/32"]
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
