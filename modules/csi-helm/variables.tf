################################################################################
# SECRETS DRIVER/PROVIDER HELM
################################################################################
variable "project" {
  description = "Project Name"
  type        = string
}
variable "environment" {
  description = "Project Environment"
  type        = string
}
variable "framework" {
  description = "Application Framework"
  type        = string
  default     = "demo"
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
variable "secret_manager_arn" {
  description = "Secret Manager Arn"
  type        = string
}
