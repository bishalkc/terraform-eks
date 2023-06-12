# ECR outputs

output "ecr" {
  description = "ECR URL"
  value       = aws_ecr_repository.ecr.repository_url
}
