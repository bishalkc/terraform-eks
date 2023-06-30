# SA ROLE outputs
output "service_role_arn" {
  description = "Service Role Arn"
  value       = try(aws_iam_role.service_role[*].arn, null)
}
