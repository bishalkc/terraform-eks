################################################################################
# LB CONTROLLER
################################################################################
data "aws_iam_policy_document" "lb_controrller_role_policy" {
  count = var.enable_lb_controller ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.aws_oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [var.aws_oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "lb_controller_role" {
  count              = var.enable_lb_controller ? 1 : 0
  name               = "role-oidc-lb-controller-${var.project}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.lb_controrller_role_policy[count.index].json

  tags = {
    Name     = "role-oidc-lb-controller-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_policy" "lb_controller_role_policy" {
  count       = var.enable_lb_controller ? 1 : 0
  name        = "policy-oidc-lb-controller-${var.project}-${var.environment}"
  path        = "/"
  description = "Policy for EKS LoadBalancer Controller of EKS ${var.project} ${var.environment}"
  policy      = file("${path.module}/policies/eks_lb_controller_policy.json")

  tags = {
    Name     = "policy-oidc-lb-controller-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }
}

resource "aws_iam_role_policy_attachment" "lb_controller_policy_attachment" {
  count = var.enable_lb_controller ? 1 : 0

  policy_arn = aws_iam_policy.lb_controller_role_policy[count.index].arn
  role       = aws_iam_role.lb_controller_role[count.index].name

  depends_on = [
    aws_iam_policy.lb_controller_role_policy,
  ]
}

################################################################################
# LB SERVICE ACCOUNT
################################################################################
resource "kubernetes_service_account_v1" "lb_service_account" {
  count = var.enable_lb_controller ? 1 : 0
  metadata {
    name = "aws-load-balancer-controller"
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
    }
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lb_controller_role[count.index].arn
    }
  }
  automount_service_account_token = true
  depends_on                      = [aws_iam_role.lb_controller_role]
}


# ################################################################################
# # LB CONTROLLER HELM
# ################################################################################

resource "helm_release" "alb_load_balancer_controller" {
  count = var.enable_lb_controller ? 1 : 0

  name       = "eks"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.lb_service_account[count.index].metadata[0].name
  }
  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  depends_on = [kubernetes_service_account_v1.lb_service_account]
}
