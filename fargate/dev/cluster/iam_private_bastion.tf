resource "aws_iam_instance_profile" "private_bastion_ip" {

  name = "ip-private-${local.project}-${local.environment}"
  role = aws_iam_role.private_bastion_role.name

  depends_on = [
    aws_iam_role.private_bastion_role,
  ]

  tags = {
    Name     = "ip-private-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "instance"
    Resource = "instance_profile"
  }

}

resource "aws_iam_role" "private_bastion_role" {

  name               = "role-private-${local.project}-${local.environment}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Name     = "role-private-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "instance"
    Resource = "iam_role"
  }

}


resource "aws_iam_policy" "private_bastion_eks_policy" {
  name        = "policy-private-${local.project}-${local.environment}-eks"
  path        = "/"
  description = "Policy for Public Bastion to access EKS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:*",
        ]
        Effect   = "Allow"
        Resource = aws_eks_cluster.eks.arn
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "private_bastion_eks_policy_attachment" {
  name = "attachment-policy-private-${local.project}-${local.environment}-eks"
  roles = [
    aws_iam_role.private_bastion_role.name
  ]
  policy_arn = aws_iam_policy.private_bastion_eks_policy.arn
}
