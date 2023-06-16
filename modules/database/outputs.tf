## SG - RDS security group outputs
output "sg_rds_arn" {
  description = "ARN for RDS Security Group"
  value       = try(aws_security_group.rds[*].arn, null)
}

output "sg_rds_id" {
  description = "ID for RDS Security Group"
  value       = try(aws_security_group.rds[*].id, null)
}
