terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3.0"
    }
  }
}


################################################################################
# CNI ADDON
################################################################################
resource "aws_eks_addon" "cni" {
  count = var.enable_cni ? 1 : 0

  cluster_name                = var.eks_cluster_name
  addon_name                  = var.cni_addon_name
  addon_version               = var.cni_addon_version
  service_account_role_arn    = aws_iam_role.addon_cni_role[count.index].arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name     = "${var.cni_addon_name}-${var.cni_addon_version}-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "cni"
  }
  depends_on = [aws_iam_role.addon_cni_role]

}

data "aws_iam_policy_document" "addon_cni_role_policy_document" {
  count = var.enable_cni ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.aws_oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [var.aws_oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_cni_role" {
  count = var.enable_cni ? 1 : 0

  name = "role-${var.cni_addon_name}-${var.project}-${var.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_cni_role_policy_document[count.index].json

  tags = {
    Name     = "role-${var.cni_addon_name}-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_cni_role_policy_attachment" {
  count = var.enable_cni ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.addon_cni_role[count.index].name
}

################################################################################
# EBS ADDON
################################################################################
resource "aws_eks_addon" "ebs" {
  count = var.enable_ebs ? 1 : 0

  cluster_name                = var.eks_cluster_name
  addon_name                  = var.ebs_addon_name
  addon_version               = var.ebs_addon_version
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
    Name     = "${var.ebs_addon_name}-${var.ebs_addon_version}-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "networking"
    Resource = "ebs"
  }
}

data "aws_iam_policy_document" "addon_ebs_role_policy_document" {
  count = var.enable_ebs ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.aws_oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.aws_oidc_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.aws_oidc_url]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "addon_ebs_role" {
  count = var.enable_ebs ? 1 : 0

  name = "role-${var.ebs_addon_name}-${var.project}-${var.environment}"

  assume_role_policy = data.aws_iam_policy_document.addon_ebs_role_policy_document[count.index].json

  tags = {
    Name     = "role-${var.ebs_addon_name}-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_servicerole_attachment" {
  count = var.enable_ebs ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.addon_ebs_role[count.index].name
}

# CUSTOM KMS (if you are not using custom kms disable below)
resource "aws_iam_policy" "ebs_kms_readwrite_policy" {
  count = var.enable_ebs ? 1 : 0

  name        = "policy-ebs-kms-readwrite-${var.project}-${var.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${var.project} ${var.environment}"
  policy      = file("${path.module}/policies/kms_policy.json")

  tags = {
    Name     = "policy-ebs-kms-readwrite-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }

}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_readright_policy_attachment" {
  count = var.enable_ebs ? 1 : 0

  policy_arn = aws_iam_policy.ebs_kms_readwrite_policy[count.index].arn
  role       = aws_iam_role.addon_ebs_role[count.index].name
}

resource "aws_iam_policy" "ebs_role_kms_grant_policy" {
  count = var.enable_ebs ? 1 : 0

  name        = "policy-ebs-kms-grant-${var.project}-${var.environment}"
  path        = "/"
  description = "Policy for EBS KMS ${var.project} ${var.environment}"
  policy      = file("${path.module}/policies/kms_grant_policy.json")

  tags = {
    Name     = "policy-ebs-kms-grant-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }
}

resource "aws_iam_role_policy_attachment" "addon_ebs_role_kms_grant_policy_attachment" {
  count = var.enable_ebs ? 1 : 0

  policy_arn = aws_iam_policy.ebs_role_kms_grant_policy[count.index].arn
  role       = aws_iam_role.addon_ebs_role[count.index].name
}
