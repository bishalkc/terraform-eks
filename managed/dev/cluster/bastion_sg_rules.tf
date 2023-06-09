resource "aws_security_group_rule" "ingress_22_custom" {
  type              = "ingress"
  description       = "Custom IP"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["96.255.96.189/32"]
  security_group_id = aws_security_group.bastion_public.id

}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_public.id

}

resource "aws_security_group_rule" "private_ingress_22_custom" {
  type                     = "ingress"
  description              = "Custom IP"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_public.id
  security_group_id        = aws_security_group.bastion_private.id

}

resource "aws_security_group_rule" "private_egress_all" {
  type              = "egress"
  description       = "All allowed"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_private.id

}
