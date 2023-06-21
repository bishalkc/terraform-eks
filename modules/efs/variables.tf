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
variable "description" {
  description = "The description of the parameter."
  default     = "Parameter Stores"
  type        = string
}
variable "framework" {
  description = "Type to put shared ssm paramter in"
  type        = string
  default     = "shared"
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
