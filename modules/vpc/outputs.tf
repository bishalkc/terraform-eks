## VPC Outputs
output "vpc_arn" {
  value = aws_vpc.vpc.arn
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

## SUBNETS (vpc)  - Outputs
output "public" {
  value = aws_subnet.public[*].id
}

output "database" {
  value = aws_subnet.database[*].id
}

output "cp" {
  value = aws_subnet.cp[*].id
}

output "svcs" {
  value = aws_subnet.svcs[*].id
}

output "worker" {
  value = aws_subnet.worker[*].id
}

## IGW (vpc) Outputs
output "igw_vpc_arn" {
  value = aws_internet_gateway.igw.arn
}

output "igw_vpc_id" {
  value = aws_internet_gateway.igw.id
}

## ROUTE TABLES (vpc) PUBLIC - Outputs
output "route_table_public_arn" {
  value = aws_route_table.public.arn
}

output "route_table_public_id" {
  value = aws_route_table.public.id
}


## ROUTE TABLES (vpc) PRIVATE - Outputs
output "route_table_private_arn" {
  value = aws_route_table.private.arn
}

output "route_table_private_id" {
  value = aws_route_table.private.id
}

## ELASTIC IP (vpc) NAT GATEWAYS - Outputs
output "eip_id" {
  value = aws_eip.nat.id
}

output "eip_public_ip" {
  value = aws_eip.nat.public_ip
}

## NAT Gateways (vpc) Outputs
output "ngw_id" {
  value = aws_nat_gateway.ngw.id
}

output "ngw_allocation_id" {
  value = aws_nat_gateway.ngw.allocation_id
}
