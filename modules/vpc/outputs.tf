## VPC Outputs
output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR BLOCK"
  value       = aws_vpc.vpc.cidr_block
}

## SUBNETS (vpc)  - Outputs
output "public" {
  description = "VPC Public Subnets"
  value       = aws_subnet.public[*].id
}

output "database" {
  description = "VPC Database Subnets"
  value       = aws_subnet.database[*].id
}

output "cp" {
  description = "VPC Control Pane Subnets"
  value       = aws_subnet.cp[*].id
}

output "svcs" {
  description = "VPC Services Subnet"
  value       = aws_subnet.svcs[*].id
}

output "worker" {
  description = "VPC Worker/Node Subnet"
  value       = aws_subnet.worker[*].id
}

## IGW (vpc) Outputs
output "igw_vpc_arn" {
  description = "IGW ARN"
  value       = aws_internet_gateway.igw.arn
}

output "igw_vpc_id" {
  description = "IGW ID"
  value       = aws_internet_gateway.igw.id
}

## ROUTE TABLES (vpc) PUBLIC - Outputs
output "route_table_public_arn" {
  description = "VPC Public Route Table ARN"
  value       = aws_route_table.public.arn
}

output "route_table_public_id" {
  description = "VPC Public Route Table ID"
  value       = aws_route_table.public.id
}


## ROUTE TABLES (vpc) PRIVATE - Outputs
output "route_table_private_arn" {
  description = "VPC Private Route Table ARN"
  value       = aws_route_table.private.arn
}

output "route_table_private_id" {
  description = "VPC Private Route Table ID"
  value       = aws_route_table.private.id
}

## ELASTIC IP (vpc) NAT GATEWAYS - Outputs
output "eip_id" {
  description = "VPC Elastic NAT ID"
  value       = aws_eip.nat.id
}

output "eip_public_ip" {
  description = "VPC Elastic NAT PUBLIC IP"
  value       = aws_eip.nat.public_ip
}

## NAT Gateways (vpc) Outputs
output "ngw_id" {
  description = "VPC NAT Gateway ID"
  value       = aws_nat_gateway.ngw.id
}

output "ngw_allocation_id" {
  description = "VPC NAT Gateway Allocation ID"
  value       = aws_nat_gateway.ngw.allocation_id
}

output "is_fargate" {
  description = "Is this Fargate"
  value       = var.is_fargate
}
