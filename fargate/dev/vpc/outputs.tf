## VPC Outputs
output "vpc_arn" {
  value = module.vpc.vpc_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

## SUBNETS (vpc)  - Outputs
output "public" {
  value = module.vpc.public
}

output "database" {
  value = module.vpc.database
}

output "cp" {
  value = module.vpc.cp
}

output "svcs" {
  value = module.vpc.svcs
}

output "worker" {
  value = module.vpc.worker
}

## IGW (vpc) Outputs
output "igw_vpc_arn" {
  value = module.vpc.igw_vpc_arn
}

output "igw_vpc_id" {
  value = module.vpc.igw_vpc_id
}

## ROUTE TABLES (vpc) PUBLIC - Outputs
output "route_table_public_arn" {
  value = module.vpc.route_table_public_arn
}

output "route_table_public_id" {
  value = module.vpc.route_table_public_id
}


## ROUTE TABLES (vpc) PRIVATE - Outputs
output "route_table_private_arn" {
  value = module.vpc.route_table_private_arn
}

output "route_table_private_id" {
  value = module.vpc.route_table_private_id
}

## ELASTIC IP (vpc) NAT GATEWAYS - Outputs
output "eip_id" {
  value = module.vpc.eip_id
}

output "eip_public_ip" {
  value = module.vpc.eip_public_ip
}

## NAT Gateways (vpc) Outputs
output "ngw_id" {
  value = module.vpc.ngw_id
}

output "ngw_allocation_id" {
  value = module.vpc.ngw_allocation_id
}
