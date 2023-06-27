################################################################################
# ECR
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
