################################################################################
# SERVICE ACCOUNT ROLE/POLICY
################################################################################
resource "aws_iam_role" "service_role" {
  name               = "role-secrets-${var.project}-${var.app_name}-${var.framework}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.secret_deployment_policy_document.json

  tags = {
    Name     = "role-secret-manager-${var.project}-${var.app_name}-${var.framework}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
    AppName  = var.app_name
  }

}

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
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    effect = "Allow"

    resources = [
      var.secret_manager_arn,
    ]
  }

}
resource "aws_iam_policy" "secret_manager_deployment_policy" {
  count = var.create_secret ? 1 : 0

  name   = "policy-secrets-${var.project}-${var.app_name}-${var.framework}-${var.environment}"
  policy = data.aws_iam_policy_document.secret_manager_deployment_policy_document.json
}

resource "aws_iam_role_policy_attachment" "secret_manager_deployment_policy_document" {
  count = var.create_secret ? 1 : 0

  policy_arn = aws_iam_policy.secret_manager_deployment_policy[count.index].arn
  role       = aws_iam_role.service_role.name

  depends_on = [
    aws_iam_policy.secret_manager_deployment_policy,
  ]
}

data "aws_iam_policy_document" "ssm_param_store_deployment_policy_document" {
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
      "ssm:GetParameter",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:ssm:us-east-1:${local.account_number}:parameter/${var.project}/${var.environment}/${var.app_name}/${var.framework}/*",
    ]
  }
}

resource "aws_iam_policy" "ssm_param_store_deployment_policy" {
  count = var.create_ssm ? 1 : 0

  name   = "policy-ssm-${var.project}-${var.app_name}-${var.framework}-${var.environment}"
  policy = data.aws_iam_policy_document.ssm_param_store_deployment_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ssm_param_store_deployment_policy_document" {
  count = var.create_ssm ? 1 : 0

  policy_arn = aws_iam_policy.ssm_param_store_deployment_policy[count.index].arn
  role       = aws_iam_role.service_role.name

  depends_on = [
    aws_iam_policy.ssm_param_store_deployment_policy,
  ]
}
