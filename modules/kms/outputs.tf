## KMS outputs

output "kms_key_arn" {
  description = "ARN of EKS KMS Key"
  value       = try(aws_kms_key.kms[*].arn, null)
}

output "kms_key_id" {
  description = "Key ID of EKS KMS Key"
  value       = try(aws_kms_key.kms[*].key_id, null)
}

output "kms_alias_arn" {
  description = "ARN of EKS KMS Alias for EKS Key"
  value       = try(aws_kms_alias.kms[*].arn, null)
}
