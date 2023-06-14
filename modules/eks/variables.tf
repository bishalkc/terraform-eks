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
variable "bastion_keypair_name" {
  description = "Bastion KeyPair Name"
  type        = string
}
variable "bastion_public_sg_id" {
  description = "Bastion Public Security Group"
  type        = string
  default     = "null"
}
variable "bastion_private_sg_id" {
  description = "Bastion Private Security Group"
  type        = string
  default     = "null"
}
variable "eks_lb_controller" {
  description = "Create LB Controller"
  type        = bool
  default     = false
}
variable "eks_cluster_name" {
  description = "Name of EKS Cluster"
  type        = string
}
