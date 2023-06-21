################################################################################
# EFS
################################################################################
resource "aws_efs_file_system" "efs" {
  count = var.create_efs ? 1 : 0

  creation_token   = "eks"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  tags = {
    Name     = "efs-${var.project}-${var.environment}"
    Tier     = "private"
    Role     = "ecr"
    Resource = "ecr"
  }
}

################################################################################
# EFS TARGET
################################################################################

resource "aws_efs_mount_target" "zone_a" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[0]
  security_groups = [var.eks_security_group_id]
}
resource "aws_efs_mount_target" "zone_b" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[1]
  security_groups = [var.eks_security_group_id]
}
resource "aws_efs_mount_target" "zone_c" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[2]
  security_groups = [var.eks_security_group_id]
}

resource "aws_ssm_parameter" "cluster" {
  count = var.create_efs ? 1 : 0

  name        = "/${var.project}/${var.environment}/${var.framework}/efs_id"
  description = "${var.description}-${var.project}-${var.environment}"
  type        = var.type
  tier        = var.tier
  data_type   = var.data_type
  key_id      = var.kms_id
  value       = aws_efs_file_system.efs[count.index].id
  tags = {
    Name     = "ssm-${var.project}-${var.environment}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "param_store"
  }
  depends_on = [aws_efs_file_system.efs]
}
