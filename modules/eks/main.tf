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

  key_name = var.bastion_keypair_name

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [
    var.bastion_public_sg_id,
    var.bastion_private_sg_id,
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

################################################################################
# SECURITY GROUPS FOR BASTION HOSTS
################################################################################
## THESE ARE ADDITIONAL SG RULES FOR THE SECURITY GROUP THAT EKS CLUSTER CREATES AUTOMATICALLY
resource "aws_security_group_rule" "eks_ingress_public_bastion" {
  count = var.bastion_public_sg_id != "null" ? 1 : 0

  type                     = "ingress"
  description              = "HTTPS ingress allowed from Public Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.bastion_public_sg_id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]
}

# resource "aws_security_group_rule" "eks_ingress_private_bastion" {
#   count = var.bastion_private_sg_id != "null" ? 1 : 0

#   type                     = "ingress"
#   description              = "HTTPS ingress allowed from Private Bastion SG"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   source_security_group_id = var.bastion_private_sg_id
#   security_group_id        = data.aws_security_group.eks_auto.id

#   depends_on = [
#     aws_eks_cluster.eks,
#   ]

# }


################################################################################
# LB CONTROLLER
################################################################################
data "aws_iam_policy_document" "lb_controrller_role_policy" {
  count = var.eks_lb_controller ? 1 : 0

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
  count              = var.eks_lb_controller ? 1 : 0
  name               = "role-oidc-lb-controller-${var.project}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.lb_controrller_role_policy[count.index].json
  depends_on = [
    aws_iam_openid_connect_provider.oidc,
  ]

  tags = {
    Name     = "role-oidc-lb-controller-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_policy" "lb_controller_role_policy" {
  count       = var.eks_lb_controller ? 1 : 0
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
  count = var.eks_lb_controller ? 1 : 0

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
  count = var.eks_lb_controller ? 1 : 0
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
