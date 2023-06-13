################################################################################
# DATABASE
################################################################################
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
variable "create_database" {
  description = "Creates Database"
  type        = bool
  default     = false
}
variable "db_type" {
  description = "Define Database Type"
  type        = string
  default     = "mariadb"
}
variable "db_version" {
  description = "Define Database Version"
  type        = string
  default     = "10.5.0"
}
variable "db_port" {
  description = "Define Database port number"
  type        = number
  default     = 3306
}
variable "db_instance_type" {
  description = "Define Database Instance Type"
  type        = string
  default     = "db.t3.medium"
}
variable "vpc_id" {
  description = "Define VPC ID"
  type        = string
}
variable "db_subnet_ids" {
  description = "Define Database Subnets"
  type        = list(string)
}
variable "sg_bastion_public_id" {
  description = "Define Bastion SG ID"
  type        = string
}
