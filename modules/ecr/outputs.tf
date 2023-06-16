# ECR outputs

output "ecr_url" {
  description = "ECR URL"
  value       = try(aws_ecr_repository.ecr[*].repository_url, null)
}
