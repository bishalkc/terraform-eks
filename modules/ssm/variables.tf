################################################################################
# SECRET MANAGER VARIABLES
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
variable "framework" {
  description = "App framework"
  type        = string
  default     = "demo"
}
variable "create_ssm" {
  description = "Creates SSM"
  type        = bool
  default     = true
}
variable "kms_id" {
  description = "KMS ID for encryption"
  type        = string
}
