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
variable "framework" {
  description = "App framework"
  type        = string
  default     = "demo"
}
variable "create_secret_database" {
  description = "Creates Secret Manager for storing Database"
  type        = bool
  default     = true
}
variable "create_secret_app" {
  description = "Creates Secret Manager for storing App"
  type        = bool
  default     = false
}
variable "kms_id" {
  description = "KMS ID for encryption"
  type        = string
}
variable "secret_string" {
  description = " Secrets to populate"
  type        = map(string)
}
variable "prefix" {
  description = "Adding prefix to Secret Manager name"
  type        = string
}
