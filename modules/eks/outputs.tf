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
  value       = aws_eks_cluster.eks.certificate_authority[0].data
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
### EKS CLUSTER
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

### WORKER ROLE

output "iam_worker_role_arn" {
  description = "ARN of EKS worker IAM Role"
  value       = try(aws_iam_role.worker_role[*].arn, null)
}

output "iam_worker_role_id" {
  description = "ID of EKS worker IAM Role"
  value       = try(aws_iam_role.worker_role[*].id, null)
}

output "iam_worker_role_name" {
  description = "Name of EKS worker IAM Role"
  value       = try(aws_iam_role.worker_role[*].name, null)
}

### FARGATE ROLE
output "iam_fargate_profile_arn" {
  description = "ARN of EKS FARGATE PROFILE"
  value       = try(aws_eks_fargate_profile.fargate_profile[*].arn, null)
}

output "iam_fargate_profile_id" {
  description = "ID of EKS FARGATE PROFILE"
  value       = try(aws_eks_fargate_profile.fargate_profile[*].id, null)
}

output "iam_fargate_role_arn" {
  description = "ARN of EKS FARGATE IAM Role"
  value       = try(aws_iam_role.fargate_role[*].arn, null)
}

output "iam_fargate_role_id" {
  description = "ID of EKS FARGATE IAM Role"
  value       = try(aws_iam_role.fargate_role[*].id, null)
}

output "iam_fargate_role_name" {
  description = "Name of EKS FARGATE IAM Role"
  value       = try(aws_iam_role.fargate_role[*].name, null)
}


## Launch Template outputs

output "launch_worker_t3micro_lt_arn" {
  description = "ARN  of Launch Template for EKS-1 NodeGroup-1"
  value       = try(aws_launch_template.worker_t3micro_lt[*].arn, null)
}

output "launch_worker_t3micro_lt_id" {
  description = "ID of Launch Template for EKS-1 NodeGroup-1"
  value       = try(aws_launch_template.worker_t3micro_lt[*].id, null)
}

output "launch_worker_t3micro_lt_latest_version" {
  description = "Latest Version of Launch Template for EKS-1 NodeGroup-1"
  value       = try(aws_launch_template.worker_t3micro_lt[*].latest_version, null)
}


## EKS Node Group outputs

output "node_group_arn" {
  description = "ARN of EKS NodeGroup"
  value       = try(aws_eks_node_group.node_group[*].id, null)
}

output "node_group_id" {
  description = "ID of EKS NodeGroup"
  value       = try(aws_eks_node_group.node_group[*].id, null)
}

output "node_group_status" {
  description = "Status of EKS NodeGroup"
  value       = try(aws_eks_node_group.node_group[*].status, null)
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

#EKS Auto Generate Security group
output "eks_security_group_id" {
  description = "EKS Auto Generated Security Group ID"
  value       = try(data.aws_security_group.eks_auto.id, null)
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
