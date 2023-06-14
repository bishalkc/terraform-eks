## Cloudwatch Log Group - EKS outputs

output "cloudwatch_loggroup_eks_arn" {
  description = "ARN of Cloudwatch log group for eks"
  value       = aws_cloudwatch_log_group.eks.arn
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

output "eks_cluster_name" {
  description = "ARN of EKS Cluster 1"
  value       = aws_eks_cluster.eks.name
}

output "eks_cluster_ca_certificate" {
  description = "ARN of EKS Cluster 1"
  value       = aws_eks_cluster.eks.name
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

## Launch Template outputs

output "launch_worker_t3micro_lt_arn" {
  description = "ARN  of Launch Template for EKS-1 NodeGroup-1"
  value       = aws_launch_template.worker_t3micro_lt.arn
}

output "launch_worker_t3micro_lt_id" {
  description = "ID of Launch Template for EKS-1 NodeGroup-1"
  value       = aws_launch_template.worker_t3micro_lt.id
}

output "launch_worker_t3micro_lt_latest_version" {
  description = "Latest Version of Launch Template for EKS-1 NodeGroup-1"
  value       = aws_launch_template.worker_t3micro_lt.latest_version
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

# OIDC Outputs
output "oidc_arn" {
  description = "ARN of EKS OIDC"
  value       = aws_iam_openid_connect_provider.oidc.arn
}
output "oidc_url" {
  description = "URL of EKS OIDC"
  value       = aws_iam_openid_connect_provider.oidc.url
}
# Bastion  Outputs
output "bastion_keypair_name" {
  description = "Bastion KeyPair Name"
  value       = aws_key_pair.bastion.key_name
}

output "bastion_public_sg_id" {
  description = "Bastion Public SG ID"
  value       = try(aws_security_group.bastion_public[*].id, null)
}
output "bastion_public_sg_arn" {
  description = "Bastion Public SG ARN"
  value       = try(aws_security_group.bastion_public[*].arn, null)
}

output "bastion_private_sg_id" {
  description = "Bastion Private SG ID"
  value       = try(aws_security_group.bastion_private[*].id, null)
}

output "bastion_private_sg_arn" {
  description = "Bastion Private SG ARN"
  value       = try(aws_security_group.bastion_private[*].arn, null)
}
