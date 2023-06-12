resource "aws_iam_instance_profile" "public_bastion_ip" {

  name = "ip-public-${local.project}-${local.environment}"
  role = aws_iam_role.public_bastion_role.name

  depends_on = [
    aws_iam_role.public_bastion_role,
  ]

  tags = {
    Name     = "ip-public-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "instance"
    Resource = "instance_profile"
  }

}

resource "aws_iam_role" "public_bastion_role" {

  name               = "role-public-${local.project}-${local.environment}"
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
    Name     = "role-public-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "instance"
    Resource = "iam_role"
  }

}


resource "aws_iam_policy" "public_bastion_eks_policy" {
  name        = "policy-public-${local.project}-${local.environment}-eks"
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
        Resource = "arn:aws:eks:us-east-1:138904756338:cluster/demo-cluster-dev-eks"
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "public_bastion_eks_policy_attachment" {
  name = "attachment-policy-public-${local.project}-${local.environment}-eks"
  roles = [
    aws_iam_role.public_bastion_role.name
  ]
  policy_arn = aws_iam_policy.public_bastion_eks_policy.arn
}
