# Bastion  Outputs
output "bastion_keypair_name" {
  description = "Bastion KeyPair Name"
  value       = try(module.bastion.bastion_keypair_name, null)
}

output "bastion_public_sg_id" {
  description = "Bastion Public SG ID"
  value       = try(module.bastion.bastion_public_sg_id, null)
}
output "bastion_public_sg_arn" {
  description = "Bastion Public SG ARN"
  value       = try(module.bastion.bastion_public_sg_arn, null)
}

output "bastion_private_sg_id" {
  description = "Bastion Private SG ID"
  value       = try(module.bastion.bastion_private_sg_id, null)
}

output "bastion_private_sg_arn" {
  description = "Bastion Private SG ARN"
  value       = try(module.bastion.bastion_private_sg_arn, null)
}

## KMS outputs

output "kms_key_arn" {
  description = "ARN of EKS KMS"
  value       = try(data.terraform_remote_state.shared.outputs.kms_key_arn, null)
}

output "kms_key_id" {
  description = "Key ID of EKS KMS Key"
  value       = try(data.terraform_remote_state.shared.outputs.kms_key_id, null)
}

output "kms_alias_arn" {
  description = "ARN of EKS KMS Alias for EKS Key"
  value       = try(data.terraform_remote_state.shared.outputs.kms_alias_arn, null)
}

## Cloudwatch Log Group - EKS outputs

output "cloudwatch_loggroup_eks_arn" {
  description = "ARN of Cloudwatch log group for eks"
  value       = try(module.eks.cloudwatch_loggroup_eks_arn, null)
}

## EKS Cluster outputs

output "eks_cluster_arn" {
  description = "ARN of EKS Cluster"
  value       = try(module.eks.eks_cluster_arn, null)
}

output "eks_cluster_name" {
  description = "ARN of EKS Cluster"
  value       = try(module.eks.eks_cluster_name, null)
}

output "eks_cluster_id" {
  description = "ARN of EKS Cluster"
  value       = try(module.eks.eks_cluster_arn, null)
}

output "eks_cluster_platform_version" {
  description = "ARN of EKS Cluster"
  value       = try(module.eks.eks_cluster_platform_version, null)
}

output "eks_cluster_ca_certificate" {
  description = "Platform Version of EKS Cluster"
  value       = try(module.eks.eks_cluster_ca_certificate, null)
}

output "eks_cluster_status" {
  description = "Status of EKS Cluster"
  value       = try(module.eks.eks_cluster_status, null)
}

output "eks_cluster_endpoint" {
  description = "Endpoint of EKS Cluster"
  value       = try(module.eks.eks_cluster_endpoint, null)
}


## IAM outputs

output "iam_cluster_role_arn" {
  description = "ARN of EKS IAM Role"
  value       = try(module.eks.iam_cluster_role_arn, null)
}

output "iam_cluster_role_id" {
  description = "ID of EKS IAM Role"
  value       = try(module.eks.iam_cluster_role_id, null)
}

output "iam_cluster_role_name" {
  description = "Name of EKS IAM Role"
  value       = try(module.eks.iam_cluster_role_name, null)
}

output "iam_worker_role_arn" {
  description = "ARN of EKS worker 1 IAM Role"
  value       = try(module.eks.iam_worker_role_arn, null)
}

output "iam_worker_role_id" {
  description = "ID of EKS worker 1 IAM Role"
  value       = try(module.eks.iam_worker_role_arn, null)
}

output "iam_worker_role_name" {
  description = "Name of EKS worker 1 IAM Role"
  value       = try(module.eks.iam_worker_role_name, null)
}

## Launch Template outputs

output "launch_worker_t3micro_lt_arn" {
  description = "ARN  of Launch Template for EKS-1 NodeGroup"
  value       = try(module.eks.launch_worker_t3micro_lt_arn, null)
}

output "launch_worker_t3micro_lt_id" {
  description = "ID of Launch Template for EKS-1 NodeGroup"
  value       = try(module.eks.launch_worker_t3micro_lt_id, null)
}

output "launch_worker_t3micro_lt_latest_version" {
  description = "Latest Version of Launch Template for EKS-1 NodeGroup"
  value       = try(module.eks.launch_worker_t3micro_lt_latest_version, null)
}


## EKS Node Group outputs

output "node_group_arn" {
  description = "ARN of EKS NodeGroup"
  value       = try(module.eks.node_group_arn, null)
}

output "node_group_id" {
  description = "ID of EKS NodeGroup"
  value       = try(module.eks.node_group_id, null)
}

output "node_group_status" {
  description = "Status of EKS NodeGroup"
  value       = try(module.eks.node_group_status, null)
}

# OIDC Outputs
output "oidc_arn" {
  description = "ARN of EKS OIDC"
  value       = try(module.eks.oidc_arn, null)
}
output "oidc_url" {
  description = "URL of EKS OIDC"
  value       = try(module.eks.oidc_url, null)
}

# ECR Outputs
output "ecr_url" {
  description = "ECR URL"
  value       = try(data.terraform_remote_state.shared.outputs.ecr_url, null)
}
