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
variable "enable_lb_controller" {
  description = "Create LB Controller"
  type        = bool
  default     = false
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
variable "eks_cluster_ca_certificate" {
  description = "EKS Cluster Certificates"
  type        = string
}
variable "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  type        = string
}
