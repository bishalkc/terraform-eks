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
variable "app_name" {
  description = "App Name"
  type        = string
  default     = "app1"
}
variable "kms_id" {
  description = "KMS ID for encryption"
  type        = string
}
variable "secret_string" {
  description = " Secrets to populate"
  type        = map(string)
}
variable "secret_name" {
  description = "Secret Manager name"
  type        = string
}
variable "secret_version" {
  description = "Adding version as suffix to Secret Manager name"
  type        = string
}
variable "create_secret" {
  description = "Creates Secret Manager for storing Database"
  type        = bool
  default     = true
}
