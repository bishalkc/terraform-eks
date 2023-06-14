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
variable "value" {
  description = "The value of the parameter. This value is always marked as sensitive in the Terraform plan output, regardless of type. In Terraform CLI version 0.15 and later, this may require additional configuration handling for certain scenarios. For more information, see the Terraform v0.15 Upgrade Guide.The KMS key id or arn for encrypting a SecureString. ( https://www.terraform.io/upgrade-guides/0-15.html?&_ga=2.264038603.670901932.1623631883-573757115.1588460856#sensitive-output-values )"
  default     = null
  type        = string
}
variable "key_id" {
  description = "KMS ID for encryption"
  type        = string
}
variable "name" {
  description = "Name for SSM Parameter"
  type        = string
}
