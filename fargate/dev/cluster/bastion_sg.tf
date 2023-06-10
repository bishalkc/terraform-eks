resource "aws_security_group" "bastion_public" {
  name        = "${local.project}-${local.environment}-public"
  description = "Security Group for Bastion Host"
  vpc_id      = local.vpc_id

  tags = {
    Name     = "sg-${local.project}-${local.environment}",
    Tier      = "public"
    Role     = "instance"
    Resource = "security_group"
  }

}


resource "aws_security_group" "bastion_private" {
  name        = "${local.project}-${local.environment}-private"
  description = "Security Group for Private Bastion Host"
  vpc_id      = local.vpc_id

  tags = {
    Name     = "sg-${local.project}-${local.environment}-private",
    Tier     = "Private"
    Role     = "instance"
    Resource = "security_group"
  }

}
