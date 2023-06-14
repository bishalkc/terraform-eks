################################################################################
# EKS CLUSTER
################################################################################

resource "aws_eks_cluster" "eks" {
  name                      = var.eks_cluster_name
  version                   = var.eks_version
  role_arn                  = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  vpc_config {
    subnet_ids              = var.cp_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["${local.my_ip}/32"]
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = var.kms_key_arn
    }
  }

  timeouts {
    create = "30m"
    update = "60m"
    delete = "15m"
  }

  tags = {
    Name     = "eks-cluster-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "eks"
  }

}

################################################################################
# CLOUD WATCH
################################################################################
resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${var.project}-${var.environment}/cluster"
  retention_in_days = 14

  tags = {
    Name     = "/aws/eks/${var.project}-${var.environment}/cluster"
    Tier     = "private"
    Role     = "logs"
    Resource = "cloud_watch"
  }
}


################################################################################
# EKS CLUSTER ROLE
################################################################################

resource "aws_iam_role" "cluster_role" {
  name = "role-cluster-${var.project}-${var.environment}"

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
    Name     = "role-eks-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_policy" "cluster_role_kms_readwrite_policy" {
  name        = "policy-eks-kms-readwrite-${var.project}-${var.environment}"
  path        = "/"
  description = "Policy for EKS KMS ${var.project} ${var.environment}"
  policy      = file("${path.module}/policies/kms_policy.json")

  tags = {
    Name     = "policy-kms-readwrite-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_policy"
  }

}

resource "aws_iam_role_policy_attachment" "cluster_role_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_role_amazon_eks_vpc_resource_controller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_role_kms_readwrite" {
  policy_arn = aws_iam_policy.cluster_role_kms_readwrite_policy.arn
  role       = aws_iam_role.cluster_role.name
}

################################################################################
# NODE/WORKER ROLE
################################################################################
resource "aws_iam_role" "worker_role" {
  name = "role-worker-${var.project}-${var.environment}"

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
    Name     = "role-worker-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "worker_role_amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "worker_role_amazon_ec2_container_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

################################################################################
# NODE/WORKER GROUP
################################################################################
resource "aws_eks_node_group" "node_group" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.project}-${var.environment}-worker"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = var.worker_subnet_ids
  capacity_type   = "ON_DEMAND"

  launch_template {
    id      = aws_launch_template.worker_t3micro_lt.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size, launch_template[0].version] #, launch_template[0].version
  }

  tags = {
    Name     = "${var.project}-${var.environment}-worker"
    Tier     = "private"
    Role     = "node"
    Resource = "node_group"
  }

}

################################################################################
# NODEGROUP LAUNCH TEMPLATE
################################################################################

## NOTE: EKS Managed Worker Node is currently not compatible with defining Network Interface & IAM Profile Configurations in Launch Template and handles it via the Node Group Resource itself. 12/17/2021
resource "aws_launch_template" "worker_t3micro_lt" {

  name                    = "lt-${var.project}-${var.environment}-worker"
  description             = "Launch Template for Managed Node Groups of ${var.project} ${var.environment} with Instance Type t3.micro"
  image_id                = data.aws_ami.amazon_linux_2_latest.id
  disable_api_termination = true
  ebs_optimized           = false
  instance_type           = var.eks_instance_type
  update_default_version  = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.eks_volume_size
      volume_type           = var.eks_volume_type
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = var.kms_key_arn
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = aws_key_pair.bastion.key_name

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [
    aws_security_group.bastion_public[0].id,
    aws_security_group.bastion_public[0].id,
    aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  ]

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh ${aws_eks_cluster.eks.id}

--==MYBOUNDARY==--
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name     = "worker-${var.project}-${var.environment}"
      Tier     = "private"
      Role     = "eks"
      Resource = "ec2"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name      = "/dev/xvda-worker-${var.project}-${var.environment}"
      Encrypted = "true"
      Tier      = "private"
      Role      = "eks"
      Resource  = "volume"
    }
  }

}


################################################################################
# OIDC PROVIDER
################################################################################
resource "aws_iam_openid_connect_provider" "oidc" {

  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  client_id_list = [
    "sts.amazonaws.com",
  ]

  depends_on = [
    aws_eks_cluster.eks,
  ]

  tags = {
    Name     = "oidc-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "openid_connector"
  }

}

data "template_file" "public" {
  template = file("${path.module}/files/bastion_userdata.tpl")

  vars = {
    hostname = "${var.project}-${var.environment}.svcs.local"
    fqdn     = "${var.project}-${var.environment}.svcs.local"
    version  = var.eks_version
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
################################################################################
# BASTION PUBLIC
################################################################################
################################################################################


################################################################################
# BASTION PUBLIC INSTANCE
################################################################################
resource "aws_instance" "bastion_public" {
  count = var.create_public_bastion ? 1 : 0

  ami                         = data.aws_ami.bastion_amazon_linux_2_latest.id
  associate_public_ip_address = true
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.public_bastion_ip[count.index].name
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = var.vpc_public_subnet
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
      Name      = "/dev/xvda-${var.project}-${var.environment}"
      Tier      = "primary"
      Encrypted = "true"
      Role      = "volume"
      Tier      = "private"
      Resource  = "ebs"
    }
  }

  depends_on = [aws_iam_role.public_bastion_role, aws_security_group.bastion_public]
  tags = {
    Name      = "${var.project}-${var.environment}"
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
  count = var.create_public_bastion ? 1 : 0

  name = "ip-public-${var.project}-${var.environment}"
  role = aws_iam_role.public_bastion_role[count.index].name

  depends_on = [
    aws_iam_role.public_bastion_role,
  ]

  tags = {
    Name     = "ip-public-${var.project}-${var.environment}"
    Tier     = "public"
    Role     = "instance"
    Resource = "instance_profile"
  }

}

################################################################################
# BASTION PUBLIC ROLE
################################################################################
resource "aws_iam_role" "public_bastion_role" {
  count = var.create_public_bastion ? 1 : 0

  name               = "role-public-${var.project}-${var.environment}"
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
    Name     = "role-public-${var.project}-${var.environment}"
    Tier     = "public"
    Role     = "instance"
    Resource = "iam_role"
  }

}

################################################################################
# BASTION EKS PUBLIC POLICY
################################################################################
resource "aws_iam_policy" "public_bastion_eks_policy" {
  count = var.create_public_bastion ? 1 : 0

  name        = "policy-public-${var.project}-${var.environment}-eks"
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

resource "aws_iam_policy_attachment" "public_bastion_eks_policy_attachment" {
  count = var.create_public_bastion ? 1 : 0

  name = "attachment-policy-public-${var.project}-${var.environment}-eks"
  roles = [
    aws_iam_role.public_bastion_role[count.index].name
  ]
  policy_arn = aws_iam_policy.public_bastion_eks_policy[count.index].arn
}

################################################################################
# BASTION PUBLIC SECUTIRY GROUP
################################################################################

resource "aws_security_group" "bastion_public" {
  count       = var.create_public_bastion ? 1 : 0
  name        = "${var.project}-${var.environment}-public"
  description = "Security Group for Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name     = "sg-${var.project}-${var.environment}",
    Tier     = "public"
    Role     = "instance"
    Resource = "security_group"
  }
}

resource "aws_security_group_rule" "ingress_22_custom" {
  count = var.create_public_bastion ? 1 : 0

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
  count = var.create_public_bastion ? 1 : 0

  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_public[count.index].id
  depends_on        = [aws_security_group.bastion_public]
}

resource "aws_security_group_rule" "eks_ingress_public_bastion" {
  count = var.create_private_bastion ? 1 : 0

  type                     = "ingress"
  description              = "HTTPS ingress allowed from Public Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_public[count.index].id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]
}

################################################################################
################################################################################
# BASTION PRIVATE
################################################################################
################################################################################


################################################################################
# BASTION PRIVATE INSTANCE
################################################################################
resource "aws_instance" "bastion_private" {
  count                       = var.create_private_bastion ? 1 : 0
  ami                         = data.aws_ami.bastion_amazon_linux_2_latest.id
  associate_public_ip_address = false
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.private_bastion_ip[count.index].name
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = var.vpc_private_subnet
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
      Name      = "/dev/xvda-${var.project}-${var.environment}"
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
    Name      = "${var.project}-${var.environment}"
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
  count = var.create_private_bastion ? 1 : 0

  name = "ip-private-${var.project}-${var.environment}"
  role = aws_iam_role.private_bastion_role[count.index].name

  depends_on = [
    aws_iam_role.private_bastion_role,
  ]

  tags = {
    Name     = "ip-private-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "instance"
    Resource = "instance_profile"
  }

}

################################################################################
# BASTION PRIVATE INSTANCE ROLE
################################################################################
resource "aws_iam_role" "private_bastion_role" {
  count = var.create_private_bastion ? 1 : 0

  name               = "role-private-${var.project}-${var.environment}"
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
    Name     = "role-private-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "instance"
    Resource = "iam_role"
  }

}

################################################################################
# BASTION PRIVATE EKS POLICY
################################################################################
resource "aws_iam_policy" "private_bastion_eks_policy" {
  count = var.create_private_bastion ? 1 : 0

  name        = "policy-private-${var.project}-${var.environment}-eks"
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
  count = var.create_private_bastion ? 1 : 0

  name = "attachment-policy-private-${var.project}-${var.environment}-eks"
  roles = [
    aws_iam_role.private_bastion_role[count.index].name
  ]
  policy_arn = aws_iam_policy.private_bastion_eks_policy[count.index].arn
}

################################################################################
# BASTION PRIVATE SECUTIRY GROUP
################################################################################
resource "aws_security_group" "bastion_private" {
  count = var.create_private_bastion ? 1 : 0

  name        = "${var.project}-${var.environment}-private"
  description = "Security Group for Private Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name     = "sg-${var.project}-${var.environment}-private",
    Tier     = "Private"
    Role     = "instance"
    Resource = "security_group"
  }

}

resource "aws_security_group_rule" "private_ingress_22_custom" {
  count = var.create_private_bastion ? 1 : 0

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
  count = var.create_private_bastion ? 1 : 0

  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_private[count.index].id
  depends_on        = [aws_security_group.bastion_private]
}

resource "aws_security_group_rule" "eks_ingress_private_bastion" {
  count = var.create_private_bastion ? 1 : 0

  type                     = "ingress"
  description              = "HTTPS ingress allowed from Private Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_private[count.index].id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]

}
