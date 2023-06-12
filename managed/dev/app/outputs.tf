## SG - RDS security group outputs
output "sg_rds_arn" {
  description = "ARN for RDS Security Group"
  value       = aws_security_group.rds.arn
}

output "sg_rds_id" {
  description = "ID for RDS Security Group"
  value       = aws_security_group.rds.id
}
