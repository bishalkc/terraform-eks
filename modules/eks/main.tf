data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks.id
}

################################################################################
# EKS CLUSTER
################################################################################

resource "aws_eks_cluster" "eks" {
  name                      = local.eks.cluster_name
  version                   = local.eks.version
  role_arn                  = aws_iam_role.cluster_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  vpc_config {
    subnet_ids              = local.vpc.cp_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["${local.my_ip}/32"]
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = local.kms.kms_key_arn
    }
  }

  timeouts {
    create = "30m"
    update = "60m"
    delete = "15m"
  }

  tags = {
    Name     = "eks-cluster-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "eks"
  }

}

################################################################################
# CLOUD WATCH
################################################################################
resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${local.project}-${local.environment}/cluster"
  retention_in_days = 14

  tags = {
    Name     = "/aws/eks/${local.project}-${local.environment}/cluster"
    Tier     = "private"
    Role     = "logs"
    Resource = "cloud_watch"
  }
}


################################################################################
# EKS CLUSTER ROLE
################################################################################

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
  policy      = file("../../../modules/policies/kms_policy.json")

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

################################################################################
# NODE/WORKER ROLE
################################################################################
resource "aws_iam_role" "worker_role" {
  name = "role-worker-${local.project}-${local.environment}"

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
    Name     = "role-worker-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "iam_role"
  }

}

resource "aws_iam_role_policy_attachment" "worker_role_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "worker_role_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_role.name
}

################################################################################
# NODE/WORKER GROUP
################################################################################
resource "aws_eks_node_group" "node_group" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${local.project}-${local.environment}-worker"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = local.vpc.worker_subnet_ids
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
    Name     = "${local.project}-${local.environment}-worker"
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

  name                    = "lt-${local.project}-${local.environment}-worker"
  description             = "Launch Template for Managed Node Groups of ${local.project} ${local.environment} with Instance Type t3.micro"
  image_id                = data.aws_ami.amazon_linux_2_latest.id
  disable_api_termination = true
  ebs_optimized           = false
  instance_type           = local.eks.instance_type
  update_default_version  = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = local.eks.volume_size
      volume_type           = local.eks.volume_type
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = local.kms.kms_key_arn
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = local.bastion.keypair_name

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [
    local.bastion.public_sg_id,
    local.bastion.private_sg_id,
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
      Name     = "worker-${local.project}-${local.environment}"
      Tier     = "private"
      Role     = "eks"
      Resource = "ec2"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name      = "/dev/xvda-worker-${local.project}-${local.environment}"
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

################################################################################
# SECURITY GROUPS FOR BASTION HOSTS
################################################################################
## THESE ARE ADDITIONAL SG RULES FOR THE SECURITY GROUP THAT EKS CLUSTER CREATES AUTOMATICALLY
resource "aws_security_group_rule" "eks_ingress_public_bastion" {
  count = local.bastion.public_sg_id != "null" ? 1 : 0

  type                     = "ingress"
  description              = "HTTPS ingress allowed from Public Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = local.bastion.public_sg_id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]
}

# resource "aws_security_group_rule" "eks_ingress_private_bastion" {
#   count = local.bastion.private_sg_id != "null" ? 1 : 0

#   type                     = "ingress"
#   description              = "HTTPS ingress allowed from Private Bastion SG"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   source_security_group_id = local.bastion.private_sg_id
#   security_group_id        = data.aws_security_group.eks_auto.id

#   depends_on = [
#     aws_eks_cluster.eks,
#   ]

# }


################################################################################
# LB CONTROLLER
################################################################################
data "aws_iam_policy_document" "lb_controrller_role_policy" {
  count = local.eks.lb_controller ? 1 : 0

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
  count              = local.eks.lb_controller ? 1 : 0
  name               = "role-oidc-lb-controller-${local.project}-${local.environment}"
  assume_role_policy = data.aws_iam_policy_document.lb_controrller_role_policy[count.index].json
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
  count       = local.eks.lb_controller ? 1 : 0
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
  count      = local.eks.lb_controller ? 1 : 0
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
  count = local.eks.lb_controller ? 1 : 0
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
