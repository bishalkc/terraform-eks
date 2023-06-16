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

resource "aws_efs_mount_target" "zone-a" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[0]
  security_groups = [var.eks_security_group_id]
}
resource "aws_efs_mount_target" "zone-b" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[1]
  security_groups = [var.eks_security_group_id]
}
resource "aws_efs_mount_target" "zone-c" {
  count = var.create_efs ? 1 : 0

  file_system_id  = aws_efs_file_system.efs[count.index].id
  subnet_id       = var.worker_subnet_ids[2]
  security_groups = [var.eks_security_group_id]
}
