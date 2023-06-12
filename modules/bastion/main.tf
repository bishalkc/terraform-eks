data "template_file" "public" {
  template = file("${path.module}/files/bastion_userdata.tpl")

  vars = {
    hostname = "${local.project}-${local.environment}.svcs.local"
    fqdn     = "${local.project}-${local.environment}.svcs.local"
    version  = local.bastion.eks_version
  }
}

################################################################################
# BASTION KEY PAIR
################################################################################
resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCt+ReNnPHoKgSLpQCdZQ8kOn5rpkICTHskQEezhyvu/27e6XzZ/8QUtBR6rdN+pjRbcRgP9lRK7xONamEgvRYBWQDaRBirgiEPEMLZC30a/ouDJlwnJdppBHRB0VV3Dilg1kdg1y1wDXnTGA0yZeBwIt8NXDHrugYnA1SBbGRHSKaFFK5WelyTbLO2q53sipF+8PvPw847Yz/8zIAeYXnMZJSSKRVTRBoDsFjx1jQo+mfsXc7pZ4JJ+Eyq926auuIAKHkFUrIaBg8FTP/3lyIB8Cd2IwH7AM97oZSUYB6R0RAOo6hEiXNarozkjks2jt4ZRT9pym4yxzS9a/jRhb5wa7oCUQyQXinzdaQIITVm767+Wl32Q9v/q9NG9uOBsKRiMDnjvt6idsDMEakBRP2lPj2svnSRnFe+2PQjJECShRM9RG4zfrLOENA0c7TEG0x9cH4xl1P+EeZcVne1IzYIZOL942haXzgIkwnLOxnD3VzrAf35YOvBHzBsE5EUxfE= bkc@bishals-mbp.lan"
}

################################################################################
# BASTION INSTANCE
################################################################################
resource "aws_instance" "bastion_public" {
  count = local.bastion.create_public ? 1 : 0

  ami                         = data.aws_ami.bastion_amazon_linux_2_latest.id
  associate_public_ip_address = true
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.public_bastion_ip[count.index].name
  instance_type               = local.bastion.instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = local.vpc.subnet_public
  user_data                   = data.template_file.public.rendered
  vpc_security_group_ids      = [aws_security_group.bastion_public[count.index].id]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name      = "/dev/xvda-${local.project}-${local.environment}"
      Tier      = "primary"
      Encrypted = "true"
      Role      = "volume"
      Tier      = "private"
      Resource  = "ebs"
    }
  }

  depends_on = [aws_iam_role.public_bastion_role, aws_security_group.bastion_public]
  tags = {
    Name      = "${local.project}-${local.environment}"
    Host_Type = "static"
    Tier      = "public"
    Role      = "instance"
    Resource  = "ec2"
  }

  #To get eks cluster config: aws eks update-kubeconfig --name ccp-sandbox-eks-1 --kubeconfig ~/.kube/config --region us-east-1

}

################################################################################
# BASTION PUBLIC INSTANCE PROFILE
################################################################################
resource "aws_iam_instance_profile" "public_bastion_ip" {
  count = local.bastion.create_public ? 1 : 0

  name = "ip-public-${local.project}-${local.environment}"
  role = aws_iam_role.public_bastion_role[count.index].name

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

################################################################################
# BASTION PUBLIC ROLE
################################################################################
resource "aws_iam_role" "public_bastion_role" {
  count = local.bastion.create_public ? 1 : 0

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

################################################################################
# BASTION EKS PUBLIC POLICY
################################################################################
resource "aws_iam_policy" "public_bastion_eks_policy" {
  count = local.bastion.create_public ? 1 : 0

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
        Resource = "arn:aws:eks:${local.aws_region}:${local.account_number}:cluster/${local.eks.cluster_name}"
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "public_bastion_eks_policy_attachment" {
  count = local.bastion.create_public ? 1 : 0

  name = "attachment-policy-public-${local.project}-${local.environment}-eks"
  roles = [
    aws_iam_role.public_bastion_role[count.index].name
  ]
  policy_arn = aws_iam_policy.public_bastion_eks_policy[count.index].arn
}

################################################################################
# BASTION PUBLIC SECUTIRY GROUP
################################################################################

resource "aws_security_group" "bastion_public" {
  count       = local.bastion.create_public ? 1 : 0
  name        = "${local.project}-${local.environment}-public"
  description = "Security Group for Bastion Host"
  vpc_id      = local.vpc.vpc_id

  tags = {
    Name     = "sg-${local.project}-${local.environment}",
    Tier     = "public"
    Role     = "instance"
    Resource = "security_group"
  }
}

resource "aws_security_group_rule" "ingress_22_custom" {
  count = local.bastion.create_public ? 1 : 0

  type              = "ingress"
  description       = "Custom IP"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${local.my_ip}/32"]
  security_group_id = aws_security_group.bastion_public[count.index].id
  depends_on        = [aws_security_group.bastion_public]
}

resource "aws_security_group_rule" "egress_all" {
  count = local.bastion.create_public ? 1 : 0

  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_public[count.index].id
  depends_on        = [aws_security_group.bastion_public]
}

################################################################################
# BASTION PRIVATE INSTANCE
################################################################################
resource "aws_instance" "bastion_private" {
  count                       = local.bastion.create_private ? 1 : 0
  ami                         = data.aws_ami.bastion_amazon_linux_2_latest.id
  associate_public_ip_address = false
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.private_bastion_ip[count.index].name
  instance_type               = local.bastion.instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = local.vpc.subnet_private
  user_data                   = data.template_file.public.rendered
  vpc_security_group_ids      = [aws_security_group.bastion_private[count.index].id]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
  depends_on = [aws_iam_role.private_bastion_role, aws_security_group.bastion_private]
  root_block_device {
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name      = "/dev/xvda-${local.project}-${local.environment}"
      Tier      = "primary"
      Encrypted = "true"
      Role      = "volume"
      Tier      = "private"
      Resource  = "ebs"
    }
  }

  lifecycle {
    ignore_changes = [user_data, ami]
  }

  tags = {
    Name      = "${local.project}-${local.environment}"
    Host_Type = "static"
    Tier      = "public"
    Role      = "instance"
    Resource  = "ec2"
  }
}

################################################################################
# BASTION PRIVATE INSTANCE PROFILE
################################################################################
resource "aws_iam_instance_profile" "private_bastion_ip" {
  count = local.bastion.create_private ? 1 : 0

  name = "ip-private-${local.project}-${local.environment}"
  role = aws_iam_role.private_bastion_role[count.index].name

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

################################################################################
# BASTION PRIVATE INSTANCE ROLE
################################################################################
resource "aws_iam_role" "private_bastion_role" {
  count = local.bastion.create_private ? 1 : 0

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

################################################################################
# BASTION PRIVATE EKS POLICY
################################################################################
resource "aws_iam_policy" "private_bastion_eks_policy" {
  count = local.bastion.create_private ? 1 : 0

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
        Resource = "arn:aws:eks:${local.aws_region}:${local.account_number}:cluster/${local.eks.cluster_name}"
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "private_bastion_eks_policy_attachment" {
  count = local.bastion.create_private ? 1 : 0

  name = "attachment-policy-private-${local.project}-${local.environment}-eks"
  roles = [
    aws_iam_role.private_bastion_role[count.index].name
  ]
  policy_arn = aws_iam_policy.private_bastion_eks_policy[count.index].arn
}

################################################################################
# BASTION PRIVATE SECUTIRY GROUP
################################################################################
resource "aws_security_group" "bastion_private" {
  count = local.bastion.create_private ? 1 : 0

  name        = "${local.project}-${local.environment}-private"
  description = "Security Group for Private Bastion Host"
  vpc_id      = local.vpc.vpc_id

  tags = {
    Name     = "sg-${local.project}-${local.environment}-private",
    Tier     = "Private"
    Role     = "instance"
    Resource = "security_group"
  }

}

resource "aws_security_group_rule" "private_ingress_22_custom" {
  count = local.bastion.create_private ? 1 : 0

  type              = "ingress"
  description       = "Custom IP"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${local.my_ip}/32"]
  security_group_id = aws_security_group.bastion_private[count.index].id
  depends_on        = [aws_security_group.bastion_private]
}

resource "aws_security_group_rule" "private_egress_all" {
  count = local.bastion.create_private ? 1 : 0

  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_private[count.index].id
  depends_on        = [aws_security_group.bastion_private]
}
