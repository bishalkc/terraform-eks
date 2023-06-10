resource "aws_iam_openid_connect_provider" "oidc" {

  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  client_id_list = [
    "sts.amazonaws.com",
  ]

  depends_on = [
    aws_eks_cluster.eks,
  ]

  tags = {
    Name     = "oidc-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "openid_connector"
  }

}
