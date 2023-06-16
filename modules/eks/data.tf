# Data Source to utilize caller's Account Number, ARN, ID and User ID
data "aws_ami" "amazon_linux_2_latest" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.27-v*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "bastion_amazon_linux_2_latest" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## ami-019904275ee6b71a3

## THIS IS A DATA LOOKUP FOR THE SECURITY GROUP THAT EKS CLUSTER CREATES AUTOMATICALLY
data "aws_security_group" "eks_auto" {
  filter {
    name   = "group-name"
    values = ["*${var.eks_cluster_name}*"]
  }
  depends_on = [aws_eks_cluster.eks]
}
