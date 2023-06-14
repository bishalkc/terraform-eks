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
variable "create_kms" {
  description = "Creates KMS Key"
  type        = bool
  default     = true
}
