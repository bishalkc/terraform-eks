################################################################################
# SECRETS DRIVER/PROVIDER HELM
################################################################################
resource "helm_release" "secret_store_csi_driver" {
  name       = "secret-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

}
resource "helm_release" "secrets_provider_aws" {
  name       = "secrets-provider-aws"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  namespace  = "kube-system"
  depends_on = [helm_release.secret_store_csi_driver]
}

################################################################################
# SERVICE ACCOUNT ROLE/POLICY
################################################################################
data "aws_iam_policy_document" "secret_deployment_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringLike"
      variable = "${replace(var.aws_oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:*:*"]
    }

    principals {
      identifiers = [var.aws_oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "secrets_role" {
  name               = "role-secrets-${var.project}-${var.environment}-${var.framework}"
  assume_role_policy = data.aws_iam_policy_document.secret_deployment_policy_document.json

  tags = {
    Name     = "role-secret-manager-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

data "aws_iam_policy_document" "secret_manager_deployment_policy_document" {
  statement {
    sid = "KMSAccess"

    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]

    effect = "Allow"

    resources = ["*"]
  }

  statement {
    sid = "SecretManagerAccess"

    actions = [
      "secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"
    ]

    effect = "Allow"

    resources = [
      var.secret_manager_arn,
    ]
  }

  statement {

    sid = "SSMDescribeAccess"

    actions = [
      "ssm:DescribeParameters"
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {

    sid = "SSMAccess"

    actions = [
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:ssm:us-east-1:${local.account_number}:parameter/${var.project}/${var.environment}/${var.framework}",
    ]
  }
}

resource "aws_iam_policy" "secret_manager_deployment_policy" {
  name   = "policy-secrets-${var.project}-${var.environment}-${var.framework}"
  policy = data.aws_iam_policy_document.secret_manager_deployment_policy_document.json
}

resource "aws_iam_role_policy_attachment" "secret_manager_deployment_policy_document" {

  policy_arn = aws_iam_policy.secret_manager_deployment_policy.arn
  role       = aws_iam_role.secrets_role.name

  depends_on = [
    aws_iam_policy.secret_manager_deployment_policy,
  ]
}
