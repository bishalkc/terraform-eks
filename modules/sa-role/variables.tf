################################################################################
# SECRETS/PARAMETER STOR ROLE POLICY
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
variable "create_secret" {
  description = "Creates Secret Manager for storing app secrets"
  type        = bool
  default     = true
}
variable "create_ssm" {
  description = "Creates Parameter Store for storing app values"
  type        = bool
  default     = true
}
variable "aws_oidc_arn" {
  description = "ARN of AWS OIDC"
  type        = string
}
variable "aws_oidc_url" {
  description = "URL of AWS OIDC"
  type        = string
}
variable "secret_manager_arn" {
  description = "Sercret Manager ARN"
  type        = string
}
