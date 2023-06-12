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
variable "base_cidr" {
  description = "Base CIDR for VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "az_count" {
  type = number
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnets"
  type        = string
}

variable "database_subnet_cidr" {
  description = "CIDR block for database subnets"
  type        = string
}

variable "cp_subnet_cidr" {
  description = "CIDR block for control plane subnets"
  type        = string
}

variable "svcs_subnet_cidr" {
  description = "CIDR block for services subnets"
  type        = string
}

variable "worker_subnet_cidr" {
  description = "CIDR block for worker subnets"
  type        = string
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Assign auto generated ipv6 CIDR Block"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
