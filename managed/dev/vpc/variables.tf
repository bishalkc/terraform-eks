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

variable "public_subnet_cidr" {
  description = "CIDR block for public subnets"
  type        = string
  default     = "/26" # 64 - 5 (AWS RESERVES) = 59 * 3
}

variable "database_subnet_cidr" {
  description = "CIDR block for database subnets"
  type        = string
  default     = "/27" # 32 - 5 (AWS RESERVES) = 27 * 3
}

variable "cp_subnet_cidr" {
  description = "CIDR block for control plane subnets"
  type        = string
  default     = "/28" # 16 - 5 (AWS RESERVES) = 11 * 3
}

variable "svcs_subnet_cidr" {
  description = "CIDR block for services subnets"
  type        = string
  default     = "/27" # 32 - 5 (AWS RESERVES) = 27 * 3
}

variable "worker_subnet_cidr" {
  description = "CIDR block for worker subnets"
  type        = string
  default     = "/20" # 4096 - 5 (AWS RESERVES) = 4091 * 3
}
