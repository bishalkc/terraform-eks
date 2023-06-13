################################################################################
# SSM
################################################################################
resource "aws_secretsmanager_secret" "database" {
  count = local.secret_manager.database ? 1 : 0

  name       = "${lower(local.project)}/${lower(local.environment)}/${lower(local.framework)}/database"
  kms_key_id = local.kms_id

  tags = {
    Name     = "secret-manager-${local.project}-${local.environment}-${lower(local.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}


resource "aws_secretsmanager_secret" "app" {
  count = local.secret_manager.app ? 1 : 0

  name       = "${lower(local.project)}/${lower(local.environment)}/${lower(local.framework)}/app"
  kms_key_id = local.kms_id

  tags = {
    Name     = "secret-manager-${local.project}-${local.environment}-${lower(local.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}
