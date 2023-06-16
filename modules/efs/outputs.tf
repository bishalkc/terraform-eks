# EFS Outputs

output "efs_arn" {
  description = "ECR URL"
  value       = try(aws_efs_file_system.efs[*].arn, null)
}
output "efs_id" {
  description = "ECR URL"
  value       = try(aws_efs_file_system.efs[*].id, null)
}
output "efs_domain_name" {
  description = "ECR URL"
  value       = try(aws_efs_file_system.efs[*].dns_name, null)
}
output "efs_az_id" {
  description = "ECR URL"
  value       = try(aws_efs_file_system.efs[*].availability_zone_id, null)
}
