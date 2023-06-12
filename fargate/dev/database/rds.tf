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

resource "aws_db_parameter_group" "rds_paramgroup" {
  name        = "rds-pg-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  family      = local.db.type
  description = "RDS param group for rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
}


resource "aws_db_subnet_group" "rds_subnetgroup" {
  name        = "rds-sbng-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  description = "${local.db.type} DB subnet group for rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
  subnet_ids  = data.terraform_remote_state.common.outputs.database
}

resource "aws_db_instance" "rds_instance" {
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
  tags = {
    Name     = "rds-${local.db.type}-${lower(local.project)}-${lower(local.environment)}"
    Role     = "database"
    Tier     = "private"
    Resource = "rds"
  }
}
