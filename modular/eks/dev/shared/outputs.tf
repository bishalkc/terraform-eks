output "ecr_url" {
  description = "ECR URL"
  value       = try(module.ecr.ecr_url, null)
}


## KMS outputs

output "kms_key_arn" {
  description = "ARN of EKS KMS Key"
  value       = try(module.kms.kms_key_arn, null)
}

output "kms_key_id" {
  description = "Key ID of EKS KMS Key"
  value       = try(module.kms.kms_key_id, null)
}

output "kms_alias_arn" {
  description = "ARN of EKS KMS Alias for EKS Key"
  value       = try(module.kms.kms_alias_arn, null)
}
