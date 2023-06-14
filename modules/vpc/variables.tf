variable "project" {
  description = "Project Name"
  type        = string
}
variable "environment" {
  description = "Project Environment"
  type        = string
}
variable "base_cidr" {
  description = "Base CIDR for VPC"
  type        = string
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "az_count" {
  description = "Set Number of AZ's"
  type        = number
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Assign auto generated ipv6 CIDR Block"
  type        = bool
  default     = true
}
