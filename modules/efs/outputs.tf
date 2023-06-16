# EFS Outputs

output "efs_arn" {
  description = "EFS ARN"
  value       = try(aws_efs_file_system.efs[*].arn, null)
}
output "efs_id" {
  description = "EFS ID"
  value       = try(aws_efs_file_system.efs[*].id, null)
}
output "efs_domain_name" {
  description = "EFS NAME"
  value       = try(aws_efs_file_system.efs[*].dns_name, null)
}
output "efs_az_id" {
  description = "EFS AZ ID"
  value       = try(aws_efs_file_system.efs[*].availability_zone_id, null)
}
