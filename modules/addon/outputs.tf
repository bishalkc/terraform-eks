# EKS Addons Outputs
output "addon_vpc_cni_arn" {
  description = "ARN of EKS VPC-CNI Addon"
  value       = aws_eks_addon.cni[*].arn
}

output "addon_vpc_cni_id" {
  description = "ID of EKS VPC-CNI Addon"
  value       = aws_eks_addon.cni[*].id
}


# EKS Addons Outputs
output "addon_vpc_ebs_arn" {
  description = "ARN of EKS AWS-EBS Addon"
  value       = try(aws_eks_addon.ebs[*].arn, null)
}

output "addon_vpc_ebs_id" {
  description = "ID of EKS AWS-EBS Addon"
  value       = try(aws_eks_addon.ebs[*].id, null)
}
