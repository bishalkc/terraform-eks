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

variable "enable_cni" {
  description = "Enable CNI Addon"
  type        = bool
}
variable "enable_ebs" {
  description = "Enable EBS Addon"
  type        = bool
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
variable "eks_cluster_name" {
  description = "Name of the cluster"
  type        = string
}
