resource "aws_eks_addon" "ebs" {
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = local.eks.ebs_addon.name
  addon_version               = local.eks.ebs_addon.version
  service_account_role_arn    = aws_iam_role.addon_ebs_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
  depends_on = [ aws_eks_node_group.node_group, aws_iam_role.addon_ebs_role ]
  
  tags = {
    Name     = "${local.eks.ebs_addon.name}-${local.eks.ebs_addon.version}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "ebs"
  }
}

data "aws_iam_policy_document" "addon_ebs_role_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_ebs_role" {
  name = "role-${local.eks.ebs_addon.name}-${local.project}-${local.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_ebs_role_policy_document.json

  depends_on = [
    aws_iam_openid_connect_provider.oidc,
  ]

  tags = {
    Name     = "role-${local.eks.ebs_addon.name}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_servicerole_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.addon_ebs_role.name
}

// CUSTOM KMS (if you are not using custom kms disable below)
resource "aws_iam_policy" "ebs_kms_readwrite_policy" {
  name        = "policy-ebs-kms-readwrite-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${local.project} ${local.environment}"
  policy      = file("../policies/kms_policy.json")

  tags = {
    Name     = "policy-ebs-kms-readwrite-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_readright_policy_attachment" {
  policy_arn = aws_iam_policy.ebs_kms_readwrite_policy.arn
  role       = aws_iam_role.addon_ebs_role.name
}

resource "aws_iam_policy" "ebs_role_kms_grant_policy" {
  name        = "policy-ebs-kms-grant-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${local.project} ${local.environment}"
  policy      = file("../policies/kms_grant_policy.json")

  tags = {
    Name     = "policy-ebs-kms-grant-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }
}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_grant_policy_attachment" {
  policy_arn = aws_iam_policy.ebs_role_kms_grant_policy.arn
  role       = aws_iam_role.addon_ebs_role.name
}