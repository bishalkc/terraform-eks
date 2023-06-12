## Cloudwatch Log Group - EKS outputs

output "cloudwatch_loggroup_eks_arn" {
  description = "ARN of Cloudwatch log group for eks"
  value       = aws_cloudwatch_log_group.eks.arn
}

# ECR outputs

output "ecr" {
  description = "ECR URL"
  value       = aws_ecr_repository.ecr.repository_url
}

## EKS Cluster outputs

output "eks_cluster_arn" {
  description = "ARN of EKS Cluster 1"
  value       = aws_eks_cluster.eks.arn
}

output "eks_cluster_id" {
  description = "ARN of EKS Cluster 1"
  value       = aws_eks_cluster.eks.id
}

output "eks_cluster_platform_version" {
  description = "Platform Version of EKS Cluster 1"
  value       = aws_eks_cluster.eks.platform_version
}

output "eks_cluster_status" {
  description = "Status of EKS Cluster 1"
  value       = aws_eks_cluster.eks.status
}

output "eks_cluster_endpoint" {
  description = "Endpoint of EKS Cluster 1"
  value       = aws_eks_cluster.eks.endpoint
}


## IAM outputs

output "iam_cluster_role_arn" {
  description = "ARN of EKS IAM Role"
  value       = aws_iam_role.cluster_role.arn
}

output "iam_cluster_role_id" {
  description = "ID of EKS IAM Role"
  value       = aws_iam_role.cluster_role.id
}

output "iam_cluster_role_name" {
  description = "Name of EKS IAM Role"
  value       = aws_iam_role.cluster_role.name
}

output "iam_worker_role_arn" {
  description = "ARN of EKS worker 1 IAM Role"
  value       = aws_iam_role.worker_role.arn
}

output "iam_worker_role_id" {
  description = "ID of EKS worker 1 IAM Role"
  value       = aws_iam_role.worker_role.id
}

output "iam_worker_role_name" {
  description = "Name of EKS worker 1 IAM Role"
  value       = aws_iam_role.worker_role.name
}



## KMS outputs

output "kms_key_arn" {
  description = "ARN of EKS KMS Key 1"
  value       = aws_kms_key.kms.arn
}

output "kms_key_id" {
  description = "Key ID of EKS KMS Key 1"
  value       = aws_kms_key.kms.key_id
}

output "kms_alias_arn" {
  description = "ARN of EKS KMS Alias for EKS Key 1"
  value       = aws_kms_alias.kms.arn
}


## EKS Node Group outputs

output "node_group_arn" {
  description = "ARN of EKS NodeGroup"
  value       = aws_eks_node_group.node_group[*].id
}

output "node_group_id" {
  description = "ID of EKS NodeGroup"
  value       = aws_eks_node_group.node_group[*].id
}

output "node_group_status" {
  description = "Status of EKS NodeGroup"
  value       = aws_eks_node_group.node_group[*].status
}



# EKS Addons Outputs
output "addon_vpc_cni_arn" {
  description = "ARN of EKS-1 VPC-CNI Addon"
  value       = aws_eks_addon.cni.arn
}

output "addon_vpc_cni_id" {
  description = "ID of EKS-1 VPC-CNI Addon"
  value       = aws_eks_addon.cni.id
}

# OIDC Outputs
output "oidc_arn" {
  description = "ARN of EKS-1 OIDC"
  value       = aws_iam_openid_connect_provider.oidc.arn
}
