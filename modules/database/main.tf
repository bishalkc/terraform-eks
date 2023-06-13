################################################################################
# RANDOM PASSWORD
################################################################################
resource "random_password" "rds_admin" {
  length      = 24
  special     = false
  lower       = true
  upper       = true
  numeric     = true
  min_numeric = 4
  min_lower   = 4
  min_upper   = 4
}

################################################################################
# RDS PARAMGROUP
################################################################################
resource "aws_db_parameter_group" "rds_paramgroup" {
  count = var.create_database ? 1 : 0

  name        = "rds-pg-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"
  family      = var.db_type
  description = "RDS param group for rds-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"

}

################################################################################
# RDS SUBNET GROUP
################################################################################
resource "aws_db_subnet_group" "rds_subnetgroup" {
  count = var.create_database ? 1 : 0

  name        = "rds-sbng-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"
  description = "${var.db_type} DB subnet group for rds-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"
  subnet_ids  = var.db_subnet_ids
  depends_on  = [aws_security_group.rds]

}

################################################################################
# RDS
################################################################################
resource "aws_db_instance" "rds_instance" {
  count = var.create_database ? 1 : 0

  identifier              = "rds-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"
  backup_retention_period = 30
  copy_tags_to_snapshot   = true
  multi_az                = false
  allocated_storage       = 20
  # iops                      = 1000
  storage_type              = "gp2"
  storage_encrypted         = true
  engine                    = var.db_type
  engine_version            = var.db_version
  instance_class            = var.db_instance_type
  db_name                   = lower(var.project)
  final_snapshot_identifier = "rds-${var.db_type}-${lower(var.project)}-${lower(var.environment)}-final"
  username                  = lower(var.project)
  password                  = random_password.rds_admin.result
  db_subnet_group_name      = aws_db_subnet_group.rds_subnetgroup[count.index].id
  parameter_group_name      = aws_db_parameter_group.rds_paramgroup[count.index].id
  vpc_security_group_ids    = [aws_security_group.rds[count.index].id]
  depends_on                = [aws_db_parameter_group.rds_paramgroup, random_password.rds_admin, aws_db_subnet_group.rds_subnetgroup]
  tags = {
    Name     = "rds-${var.db_type}-${lower(var.project)}-${lower(var.environment)}"
    Role     = "database"
    Tier     = "private"
    Resource = "rds"
  }

}
################################################################################
# RDS SECURITY GROUP
################################################################################
resource "aws_security_group" "rds" {
  count = var.create_database ? 1 : 0

  name        = "rds-${var.db_type}-${var.project}-${var.environment}"
  description = "Security Group for RDS ${upper(var.db_type)}"
  vpc_id      = var.vpc_id

  tags = {
    Name     = "sg-rds-${var.db_type}-${var.project}-${var.environment}"
    Role     = "database"
    Tier     = "private"
    Resource = "security_group"
  }

}

resource "aws_security_group_rule" "ingress_3306_bastion" {
  count = var.create_database ? 1 : 0

  type                     = "ingress"
  description              = "SG for Bastion Host"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  source_security_group_id = var.sg_bastion_public_id
  security_group_id        = aws_security_group.rds[count.index].id
  depends_on               = [aws_security_group.rds]

}

resource "aws_security_group_rule" "egress_all" {
  count = var.create_database ? 1 : 0

  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds[count.index].id
  depends_on        = [aws_security_group.rds]

}
