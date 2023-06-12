# Bastion  Outputs
output "bastion_keypair_name" {
  description = "Bastion KeyPair Name"
  value       = aws_key_pair.bastion[*].key_name
}

output "bastion_public_sg_id" {
  description = "Bastion Public SG ID"
  value       = aws_security_group.bastion_public[*].id
}
output "bastion_public_sg_arn" {
  description = "Bastion Public SG ARN"
  value       = aws_security_group.bastion_public[*].arn
}

output "bastion_private_sg_id" {
  description = "Bastion Private SG ID"
  value       = aws_security_group.bastion_private[*].id
}

output "bastion_private_sg_arn" {
  description = "Bastion Private SG ARN"
  value       = aws_security_group.bastion_private[*].arn
}
