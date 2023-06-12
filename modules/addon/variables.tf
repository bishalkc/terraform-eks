################################################################################
# KMX
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
variable "create_bastion_public" {
  description = "Creates Public Bastion"
  type        = bool
  default     = true
}
variable "create_bastion_private" {
  description = "Creates Private Bastion"
  type        = bool
  default     = false
}
variable "enable_cni" {
  description = "Enable CNI Addon"
  type        = bool
  default     = true
}
variable "enable_ebs" {
  description = "Enable EBS Addon"
  type        = bool
  default     = true
}
variable "cni_addon_name" {
  description = "Define CNI Addon Name"
  type        = string
  default     = "vpc-cni"
}
variable "cni_addon_version" {
  description = "Define CNI Addon Version"
  type        = string
  default     = "v1.12.6-eksbuild.2"
}
variable "ebs_addon_name" {
  description = "Define EBS Addon Name"
  type        = string
  default     = "aws-ebs-csi-driver"
}
variable "ebs_addon_version" {
  description = "Define EBS Addon Version"
  type        = string
  default     = "v1.19.0-eksbuild.2"
}
variable "aws_oidc_arn" {
  description = "ARN of AWS OIDC"
  type        = string
}
variable "aws_oidc_url" {
  description = "URL of OIDC"
  type        = string
}
