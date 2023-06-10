resource "aws_eks_addon" "cni" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = local.eks.cni_addon.name
  addon_version               = local.eks.cni_addon.version
  service_account_role_arn    = aws_iam_role.addon_cni_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name     = "${local.eks.cni_addon.name}-${local.eks.cni_addon.version}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "cni"
  }
}

data "aws_iam_policy_document" "addon_cni_role_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_cni_role" {
  name = "role-${local.eks.cni_addon.name}-${local.project}-${local.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_cni_role_policy_document.json


  depends_on = [
    aws_iam_openid_connect_provider.oidc,
  ]

  tags = {
    Name     = "role-${local.eks.cni_addon.name}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_cni_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.addon_cni_role.name
}
