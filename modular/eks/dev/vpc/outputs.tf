## VPC Outputs
output "vpc_arn" {
  description = "VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC Cidr Block"
  value       = module.vpc.vpc_cidr_block
}

## SUBNETS (vpc)  - Outputs
output "public" {
  description = "Public Subnets"
  value       = module.vpc.public
}

output "database" {
  description = "Database Subnets"
  value       = module.vpc.database
}

output "cp" {
  description = "CP Subnets"
  value       = module.vpc.cp
}

output "svcs" {
  description = "Services Subnets"
  value       = module.vpc.svcs
}

output "worker" {
  description = "Worker Subnets"
  value       = module.vpc.worker
}

## IGW (vpc) Outputs
output "igw_vpc_arn" {
  description = "IGW ARN"
  value       = module.vpc.igw_vpc_arn
}

output "igw_vpc_id" {
  description = "IGW ID"
  value       = module.vpc.igw_vpc_id
}

## ROUTE TABLES (vpc) PUBLIC - Outputs
output "route_table_public_arn" {
  description = "Route Table Public ARN"
  value       = module.vpc.route_table_public_arn
}

output "route_table_public_id" {
  description = "Route Table Public ID"
  value       = module.vpc.route_table_public_id
}


## ROUTE TABLES (vpc) PRIVATE - Outputs
output "route_table_private_arn" {
  description = "Route Table Private ARN"
  value       = module.vpc.route_table_private_arn
}

output "route_table_private_id" {
  description = "Route Table Private ID"
  value       = module.vpc.route_table_private_id
}

## ELASTIC IP (vpc) NAT GATEWAYS - Outputs
output "eip_id" {
  description = "EIP ID"
  value       = module.vpc.eip_id
}

output "eip_public_ip" {
  description = "Public Elastic IP"
  value       = module.vpc.eip_public_ip
}

## NAT Gateways (vpc) Outputs
output "ngw_id" {
  description = "NAT Gatway ID"
  value       = module.vpc.ngw_id
}

output "ngw_allocation_id" {
  description = "NAT Gateway Allocation ID"
  value       = module.vpc.ngw_allocation_id
}
