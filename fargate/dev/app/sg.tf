resource "aws_security_group" "rds" {
  name        = "rds-${local.db.type}-${local.project}-${local.environment}"
  description = "Security Group for RDS ${upper(local.db.type)}"
  vpc_id      = local.vpc_id

  tags = {
    Name = "sg-rds-${local.db.type}-${local.project}-${local.environment}"
    Role     = "database"
    Tier     = "private"
    Resource = "security_group"    
  }

}
