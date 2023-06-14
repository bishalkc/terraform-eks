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
# SSM
################################################################################
resource "aws_ssm_parameter" "param" {
  name        = "/${var.project}/${var.environment}/${var.framework}/${var.name}"
  description = "${var.description}-${var.project}-${var.environment}"
  type        = var.type
  tier        = var.tier
  data_type   = var.data_type
  key_id      = var.key_id
  value       = var.value
  tags = {
    Name     = "ssm-${var.project}-${var.environment}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "param_store"
  }

}
