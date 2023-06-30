# CSI HELM outputs
output "secret_store_csi_driver_chart_name" {
  description = "Secret store csi driver ID"
  value       = try(helm_release.secret_store_csi_driver.metadata[0].name, null)
}
output "secret_store_csi_driver_chart_version" {
  description = "Secret store csi driver ID"
  value       = try(helm_release.secret_store_csi_driver.metadata[0].version, null)
}
output "secrets_provider_aws_chart_name" {
  description = "AWS Secrets provider ID"
  value       = try(helm_release.secrets_provider_aws.metadata[0].name, null)
}

output "secrets_provider_aws_chart_version" {
  description = "AWS Secrets provider ID"
  value       = try(helm_release.secrets_provider_aws.metadata[0].version, null)
}
