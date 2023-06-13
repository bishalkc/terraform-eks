################################################################################
# SECRET MANAGER
################################################################################

## DATABSE SECRET AND KEYS
resource "aws_secretsmanager_secret" "database" {
  count = local.secret_manager.database ? 1 : 0

  name       = "${lower(local.project)}/${lower(local.environment)}/${lower(local.framework)}/database-${local.prefix}"
  kms_key_id = local.kms_id

  # rotation_rules {
  #   automatically_after_days = 30
  # }

  tags = {
    Name     = "secret-manager-${local.project}-${local.environment}-${lower(local.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}

resource "aws_secretsmanager_secret_version" "secret_string" {
  count = local.secret_manager.database ? 1 : 0

  secret_id     = aws_secretsmanager_secret.database[count.index].id
  secret_string = jsonencode(var.secret_string)
  depends_on    = [aws_secretsmanager_secret.database]
}

## APP SECRET AND KEYS
resource "aws_secretsmanager_secret" "app" {
  count = local.secret_manager.app ? 1 : 0

  name       = "${lower(local.project)}/${lower(local.environment)}/${lower(local.framework)}/app-${local.prefix}"
  kms_key_id = local.kms_id

  tags = {
    Name     = "secret-manager-${local.project}-${local.environment}-${lower(local.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}
