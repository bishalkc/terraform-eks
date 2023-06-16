## SECRET MANAGER outputs

output "database_secret_manager_arn" {
  description = "ARN of Database Secret Manager"
  value       = try(module.secretmanager.database_secret_manager_arn, null)
}

output "database_secret_manager_id" {
  description = "ID of Database Secret Manager"
  value       = try(module.secretmanager.database_secret_manager_id, null)
}

output "app_secret_manager_arn" {
  description = "ARN of App Secret Manager"
  value       = try(module.secretmanager.app_secret_manager_arn, null)
}

output "app_secret_manager_id" {
  description = "ID of Database Secret Manager"
  value       = try(module.secretmanager.app_secret_manager_id, null)
}

## SSM outputs

output "ssm_parameter_arn" {
  description = "ARN of Parameter Store"
  value       = try(module.ssm.ssm_parameter_arn, null)
}
