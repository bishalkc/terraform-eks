variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "base_cidr" {
  description = "Base CIDR for VPC"
  type        = string
  default     = "10.100.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "az_count" {
  description = "AZ count declaration"
  type        = number
  default     = 3
}
