## THESE ARE ADDITIONAL SG RULES FOR THE SECURITY GROUP THAT EKS CLUSTER CREATES AUTOMATICALLY
resource "aws_security_group_rule" "eks_ingress_public_bastion" {
  type                     = "ingress"
  description              = "HTTPS ingress allowed from Public Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_public.id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]
}

resource "aws_security_group_rule" "eks_ingress_private_bastion" {
  type                     = "ingress"
  description              = "HTTPS ingress allowed from Private Bastion SG"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_private.id
  security_group_id        = data.aws_security_group.eks_auto.id

  depends_on = [
    aws_eks_cluster.eks,
  ]

}
## THESE ARE ADDITIONAL SG RULES FOR THE SECURITY GROUP THAT EKS CLUSTER CREATES AUTOMATICALLY
