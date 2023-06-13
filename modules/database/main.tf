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
  name        = "rds-pg-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  family      = local.db.type
  description = "RDS param group for rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"

}

################################################################################
# RDS SUBNET GROUP
################################################################################
resource "aws_db_subnet_group" "rds_subnetgroup" {
  name        = "rds-sbng-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  description = "${local.db.type} DB subnet group for rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  subnet_ids  = local.db.subnet_ids
  depends_on  = [aws_security_group.rds]

}

################################################################################
# RDS
################################################################################
resource "aws_db_instance" "rds_instance" {
  count                   = local.create_database ? 1 : 0
  identifier              = "rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  backup_retention_period = 30
  copy_tags_to_snapshot   = true
  multi_az                = false
  allocated_storage       = 20
  # iops                      = 1000
  storage_type              = "gp2"
  storage_encrypted         = true
  engine                    = local.db.type
  engine_version            = local.db.version
  instance_class            = local.db.instance_type
  db_name                   = lower(local.project)
  final_snapshot_identifier = "rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}-final"
  username                  = lower(local.project)
  password                  = random_password.rds_admin.result
  db_subnet_group_name      = aws_db_subnet_group.rds_subnetgroup.id
  parameter_group_name      = aws_db_parameter_group.rds_paramgroup.id
  vpc_security_group_ids    = [aws_security_group.rds.id]
  depends_on                = [aws_db_parameter_group.rds_paramgroup, random_password.rds_admin, rds_subnetgroup]
  tags = {
    Name     = "rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
    Role     = "database"
    Tier     = "private"
    Resource = "rds"
  }

}
################################################################################
# RDS SECURITY GROUP
################################################################################
resource "aws_security_group" "rds" {
  name        = "rds-${local.db.type}-${local.project}-${local.environment}"
  description = "Security Group for RDS ${upper(local.db.type)}"
  vpc_id      = local.vpc_id

  tags = {
    Name     = "sg-rds-${local.db.type}-${local.project}-${local.environment}"
    Role     = "database"
    Tier     = "private"
    Resource = "security_group"
  }

}

resource "aws_security_group_rule" "ingress_3306_bastion" {
  type                     = "ingress"
  description              = "SG for Bastion Host"
  from_port                = local.db.port
  to_port                  = local.db.port
  protocol                 = "tcp"
  source_security_group_id = local.sg_bastion_public_id
  security_group_id        = aws_security_group.rds.id
  depends_on               = [aws_security_group.rds]

}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id
  depends_on        = [aws_security_group.rds]

}
