## SSM outputs

output "ssm_parameter_arn" {
  description = "ARN of Parameter Store"
  value       = try(aws_ssm_parameter.param[*].arn, null)
}
