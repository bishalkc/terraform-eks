################################################################################
# CNI ADDON
################################################################################
resource "aws_eks_addon" "cni" {
  count = local.eks.cni_addon.enabled ? 1 : 0

  cluster_name                = local.eks.cluster_name
  addon_name                  = local.eks.cni_addon.name
  addon_version               = local.eks.cni_addon.version
  service_account_role_arn    = aws_iam_role.addon_cni_role[count.index].arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name     = "${local.eks.cni_addon.name}-${local.eks.cni_addon.version}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "cni"
  }
  depends_on = [aws_iam_role.addon_cni_role]

}

data "aws_iam_policy_document" "addon_cni_role_policy_document" {
  count = local.eks.cni_addon.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(local.eks.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [local.eks.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_cni_role" {
  count = local.eks.cni_addon.enabled ? 1 : 0

  name = "role-${local.eks.cni_addon.name}-${local.project}-${local.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_cni_role_policy_document[count.index].json

  tags = {
    Name     = "role-${local.eks.cni_addon.name}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_cni_role_policy_attachment" {
  count = local.eks.cni_addon.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.addon_cni_role[count.index].name
}

################################################################################
# EBS ADDON
################################################################################
resource "aws_eks_addon" "ebs" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  cluster_name                = local.eks.cluster_name
  addon_name                  = local.eks.ebs_addon.name
  addon_version               = local.eks.ebs_addon.version
  service_account_role_arn    = aws_iam_role.addon_ebs_role[count.index].arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
  depends_on = [aws_iam_role.addon_ebs_role]

  tags = {
    Name     = "${local.eks.ebs_addon.name}-${local.eks.ebs_addon.version}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "ebs"
  }
}

data "aws_iam_policy_document" "addon_ebs_role_policy_document" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(local.eks.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(local.eks.oidc.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [local.eks.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_ebs_role" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  name = "role-${local.eks.ebs_addon.name}-${local.project}-${local.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_ebs_role_policy_document[count.index].json

  tags = {
    Name     = "role-${local.eks.ebs_addon.name}-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_servicerole_attachment" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.addon_ebs_role[count.index].name
}

# CUSTOM KMS (if you are not using custom kms disable below)
resource "aws_iam_policy" "ebs_kms_readwrite_policy" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  name        = "policy-ebs-kms-readwrite-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${local.project} ${local.environment}"
  policy      = file("../../../modules/policies/kms_policy.json")

  tags = {
    Name     = "policy-ebs-kms-readwrite-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_readright_policy_attachment" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  policy_arn = aws_iam_policy.ebs_kms_readwrite_policy[count.index].arn
  role       = aws_iam_role.addon_ebs_role[count.index].name
}

resource "aws_iam_policy" "ebs_role_kms_grant_policy" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  name        = "policy-ebs-kms-grant-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${local.project} ${local.environment}"
  policy      = file("../../../modules/policies/kms_grant_policy.json")

  tags = {
    Name     = "policy-ebs-kms-grant-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }
}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_grant_policy_attachment" {
  count = local.eks.ebs_addon.enabled ? 1 : 0

  policy_arn = aws_iam_policy.ebs_role_kms_grant_policy[count.index].arn
  role       = aws_iam_role.addon_ebs_role[count.index].name
}
