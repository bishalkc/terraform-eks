resource "aws_security_group_rule" "ingress_3306_bastion" {
  type                     = "ingress"
  description              = "SG for Bastion Host"
  from_port                = local.db.port
  to_port                  = local.db.port
  protocol                 = "tcp"
  source_security_group_id = local.sg_bastion_public_id
  security_group_id        = aws_security_group.rds.id

}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id

}
