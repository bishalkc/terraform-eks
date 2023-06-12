data "aws_iam_policy_document" "lb_controrller_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "lb_controller_role" {
  name = "role-oidc-lb-controller-${local.project}-${local.environment}"

  assume_role_policy = data.aws_iam_policy_document.lb_controrller_role_policy.json

  depends_on = [
    aws_iam_openid_connect_provider.oidc,
  ]

  tags = {
    Name     = "role-oidc-lb-controller-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}


resource "aws_iam_policy" "lb_controller_role_policy" {
  name        = "policy-oidc-lb-controller-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EKS LoadBalancer Controller of EKS ${local.project} ${local.environment}"
  policy      = file("../../../modules/policies/eks_lb_controller_policy.json")

  tags = {
    Name     = "policy-oidc-lb-controller-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }
}


resource "aws_iam_role_policy_attachment" "lb_controller_policy_attachment" {
  policy_arn = aws_iam_policy.lb_controller_role_policy.arn
  role       = aws_iam_role.lb_controller_role.name

  depends_on = [
    aws_iam_policy.lb_controller_role_policy,
  ]
}
