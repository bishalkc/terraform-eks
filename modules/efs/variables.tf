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
variable "create_ecr" {
  description = "Creates ECR"
  type        = bool
  default     = true
}
variable "worker_subnet_ids" {
  description = "Define Worker Subnet Ids"
  type        = list(string)
}
variable "create_efs" {
  description = "Is it Fargate"
  type        = bool
  default     = false
}
variable "eks_security_group_id" {
  description = "Auto generated EKS Security Group ID"
  type        = string
}
