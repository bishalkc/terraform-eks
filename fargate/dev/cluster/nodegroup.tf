resource "aws_eks_node_group" "node_group" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${local.project}-${local.environment}-worker"
  node_role_arn   = aws_iam_role.worker_role.arn
  subnet_ids      = data.terraform_remote_state.common.outputs.worker
  capacity_type   = "ON_DEMAND"

  instance_types = [local.eks.instance_type]

  version = local.eks.version

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
    ignore_changes = [scaling_config[0].desired_size] #, launch_template[0].version
  }

  tags = {
    Name     = "${local.project}-${local.environment}-worker"
    Tier     = "private"
    Role     = "node"
    Resource = "node_group"
  }

}
