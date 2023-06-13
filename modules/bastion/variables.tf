################################################################################
# BASTION
################################################################################
variable "project" {
  description = "Project Name"
  type        = string
}
variable "environment" {
  description = "Project Environment"
  type        = string
}
variable "tenant" {
  description = "Project Tenant"
  type        = string
  default     = "demo"
}
variable "bastion_instance_type" {
  description = "Define bastion instance type"
  type        = string
  default     = "t3.micro"
}
variable "eks_version" {
  description = "Define EKS version"
  type        = string
  default     = "1.27"
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
variable "vpc_id" {
  description = "Define VPC ID"
  type        = string
}
variable "vpc_cidr_block" {
  description = "Define VPC CIDR Block"
  type        = string
}
variable "vpc_public_subnet" {
  description = "Creates Public Subnet for Bastion"
  type        = string
}
variable "vpc_private_subnet" {
  description = "Creates Public Subnet for Bastion"
  type        = string
}
variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}
