################################################################################
# SSM
################################################################################
resource "aws_ssm_parameter" "param" {
  name        = "/${local.project}/${local.environment}/${local.framework}/${var.name}"
  description = "${var.description}-${local.project}-${local.environment}"
  type        = var.type
  tier        = var.tier
  data_type   = var.data_type
  key_id      = var.key_id
  value       = var.value
  tags = {
    Name     = "ssm-${local.project}-${local.environment}-${lower(local.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "param_store"
  }

}
