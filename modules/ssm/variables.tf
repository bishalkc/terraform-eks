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
variable "description" {
  description = "The description of the parameter."
  default     = "Parameter Stores"
  type        = string
}
variable "type" {
  description = "The type of the parameter. Valid types are String, StringList and SecureString"
  default     = "SecureString"
  type        = string
}
variable "tier" {
  description = "The type of the parameter. Valid types are String, StringList and SecureString"
  default     = "Standard"
  type        = string
}
variable "data_type" {
  description = "The data_type of the parameter. Valid values: text and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs ( https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html )"
  default     = "text"
  type        = string
}
variable "kms_id" {
  description = "KMS ID for encryption"
  type        = string
}
variable "key_value" {
  description = "Name for SSM Parameter"
  type        = map(string)
}
