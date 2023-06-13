## SSM outputs

output "database_secret_manager_arn" {
  description = "ARN of Database Secret Manager"
  value       = try(aws_secretsmanager_secret.database[*].arn, null)
}

output "database_secret_manager_id" {
  description = "ID of Database Secret Manager"
  value       = try(aws_secretsmanager_secret.database[*].id, null)
}

output "app_secret_manager_arn" {
  description = "ARN of App Secret Manager"
  value       = try(aws_secretsmanager_secret.app[*].arn, null)
}

output "app_secret_manager_id" {
  description = "ID of Database Secret Manager"
  value       = try(aws_secretsmanager_secret.app[*].id, null)
}
