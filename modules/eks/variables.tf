variable "project" {
  description = "Project Name"
  type        = string
}
variable "environment" {
  description = "Project Environment"
  type        = string
}
variable "eks_version" {
  description = "Define EKS Version"
  type        = string
  default     = "1.27"
}
variable "eks_instance_type" {
  description = "Define Node Instance Type"
  type        = string
  default     = "t3.medium"
}
variable "eks_volume_size" {
  description = "Define Volume Size"
  type        = number
  default     = 20
}
variable "eks_volume_type" {
  description = "Define Volume Type"
  type        = string
  default     = "gp3"
}
variable "cp_subnet_ids" {
  description = "Define CP Subnet Ids"
  type        = list(string)
}
variable "worker_subnet_ids" {
  description = "Define Worker Subnet Ids"
  type        = list(string)
}
variable "kms_key_arn" {
  description = "Define KMS Key ARN"
  type        = string
}
variable "create_public_bastion" {
  description = "Creates Public Bastion"
  type        = bool
  default     = true
}
variable "create_private_bastion" {
  description = "Creates Private Bastion"
  type        = bool
  default     = false
}
variable "eks_cluster_name" {
  description = "Name of EKS Cluster"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "bastion_instance_type" {
  description = "Define bastion instance type"
  type        = string
  default     = "t3.micro"
}
variable "vpc_public_subnet" {
  description = "Creates Public Subnet for Bastion"
  type        = string
}
variable "vpc_private_subnet" {
  description = "Creates Public Subnet for Bastion"
  type        = string
}

variable "is_fargate" {
  description = "Is it Fargate"
  type        = bool
  default     = false
}
