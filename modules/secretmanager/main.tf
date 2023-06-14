terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3.0"
    }
  }
}


################################################################################
# SECRET MANAGER
################################################################################

## DATABSE SECRET AND KEYS
resource "aws_secretsmanager_secret" "database" {
  count = var.create_secret_database ? 1 : 0

  name       = "${lower(var.project)}/${lower(var.environment)}/${lower(var.framework)}/database-${var.prefix}"
  kms_key_id = var.kms_id

  # rotation_rules {
  #   automatically_after_days = 30
  # }

  tags = {
    Name     = "secret-manager-${var.project}-${var.environment}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}

resource "aws_secretsmanager_secret_version" "secret_string" {
  count = var.create_secret_database ? 1 : 0

  secret_id     = aws_secretsmanager_secret.database[count.index].id
  secret_string = jsonencode(var.secret_string)
  depends_on    = [aws_secretsmanager_secret.database]
}

## APP SECRET AND KEYS
resource "aws_secretsmanager_secret" "app" {
  count = var.create_secret_app ? 1 : 0

  name       = "${lower(var.project)}/${lower(var.environment)}/${lower(var.framework)}/app-${var.prefix}"
  kms_key_id = var.kms_id

  tags = {
    Name     = "secret-manager-${var.project}-${var.environment}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "secret_manager"
  }
}
