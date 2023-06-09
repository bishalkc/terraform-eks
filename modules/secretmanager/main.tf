################################################################################
# SECRET MANAGER
################################################################################

## DATABSE SECRET AND KEYS
resource "aws_secretsmanager_secret" "secrets" {
  count = var.create_secret ? 1 : 0

  name                    = "${lower(var.project)}/${lower(var.environment)}/${lower(var.app_name)}/${lower(var.framework)}/${lower(var.secret_name)}-${lower(var.secret_version)}"
  kms_key_id              = var.kms_id
  recovery_window_in_days = 7
  # rotation_rules {
  #   automatically_after_days = 30
  # }

  tags = {
    Name     = "secret-manager-${var.project}-${var.environment}-${lower(var.app_name)}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
    AppName  = var.app_name
  }
}

resource "aws_secretsmanager_secret_version" "secret_string" {
  count = var.create_secret ? 1 : 0

  secret_id     = aws_secretsmanager_secret.secrets[count.index].id
  secret_string = jsonencode(var.secret_string)
  depends_on    = [aws_secretsmanager_secret.secrets]
}
