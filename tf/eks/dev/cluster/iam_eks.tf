resource "aws_iam_role" "cluster_role" {
  name = "role-cluster-${local.project}-${local.environment}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Name     = "role-eks-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_policy" "cluster_role_kms_readwrite_policy" {
  name        = "policy-eks-kms-readwrite-${local.project}-${local.environment}"
  path        = "/"
  description = "Policy for EKS KMS ${local.project} ${local.environment}"
  policy      = file("../policies/kms_policy.json")

  tags = {
    Name     = "policy-kms-readwrite-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }

}

resource "aws_iam_role_policy_attachment" "cluster_role_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_role_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_role_kms_readwrite" {
  policy_arn = aws_iam_policy.cluster_role_kms_readwrite_policy.arn
  role       = aws_iam_role.cluster_role.name
}
