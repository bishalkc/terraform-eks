################################################################################
# CERTMANAGER HELM
################################################################################
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
variable "enable_lb_controller" {
  description = "Create Cert Manager based on LB Controller"
  type        = bool
  default     = false
}
