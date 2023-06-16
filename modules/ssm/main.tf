################################################################################
# SSM
################################################################################
resource "aws_ssm_parameter" "param" {
  for_each = var.key_value

  name        = "/${var.project}/${var.environment}/${var.framework}/${each.key}"
  description = "${var.description}-${var.project}-${var.environment}"
  type        = var.type
  tier        = var.tier
  data_type   = var.data_type
  key_id      = var.kms_id
  value       = each.value
  tags = {
    Name     = "ssm-${var.project}-${var.environment}-${lower(var.framework)}"
    Tier     = "private"
    Role     = "eks"
    Resource = "param_store"
  }

}
