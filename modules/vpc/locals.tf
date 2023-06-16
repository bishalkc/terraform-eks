locals {
  fargate_private_subnet_tags = {
    "kubernetes.io/role/internalelb"                              = "1"
    "kubernetes.io/cluster/${var.project}-${var.environment}-eks" = "owned"
  }
  fargate_public_subnet_tags = {
    "kubernetes.io/role/elb"                                      = "1"
    "kubernetes.io/cluster/${var.project}-${var.environment}-eks" = "owned"
  }
}
