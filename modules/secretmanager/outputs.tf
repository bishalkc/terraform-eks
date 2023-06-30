## SECRET MANAGER outputs

output "secret_manager_arn" {
  description = "ARN of Database Secret Manager"
  value       = try(aws_secretsmanager_secret.secrets[*].arn, null)
}

output "secret_manager_id" {
  description = "ID of Database Secret Manager"
  value       = try(aws_secretsmanager_secret.secrets[*].id, null)
}
