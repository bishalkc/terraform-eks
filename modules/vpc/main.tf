################################################################################
# VPC
################################################################################
resource "aws_vpc" "vpc" {
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  cidr_block                       = var.base_cidr
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"

  tags = {
    Name     = "vpc-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "vpc"
    Resource = "vpc"
  }
}

################################################################################
# Publiс Subnets
################################################################################

resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 10, count.index)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name     = "public-subnet-${local.project}-${local.environment}-${count.index}"
    Tier     = "public"
    Role     = "public"
    Resource = "subnet"
  }
}

################################################################################
# Database Subnets
################################################################################
resource "aws_subnet" "database" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 11, count.index + 8)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name     = "database-subnet-${local.project}-${local.environment}-${count.index}"
    Tier     = "private"
    Role     = "database"
    Resource = "subnet"
  }
}

################################################################################
# Services Subnets
################################################################################
resource "aws_subnet" "svcs" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 11, count.index + 24)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name     = "svcs-subnet-${local.project}-${local.environment}-${count.index}"
    Tier     = "private"
    Role     = "svcs"
    Resource = "subnet"
  }
}

################################################################################
# Control Pane Subnets
################################################################################
resource "aws_subnet" "cp" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 12, count.index + 32)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name     = "cp-subnet-${local.project}-${local.environment}-${count.index}"
    Tier     = "private"
    Role     = "cp"
    Resource = "subnet"
  }
}

################################################################################
# Workers Subnets
################################################################################
resource "aws_subnet" "worker" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 4, count.index + 1)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name     = "worker-subnet-${local.project}-${local.environment}-${count.index}"
    Tier     = "private"
    Role     = "worker"
    Resource = "subnet"
  }
}

################################################################################
# Public Route
################################################################################
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "public-route-table-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "route"
    Resource = "route_table"
  }
}

################################################################################
# Private Route
################################################################################
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "private-route-table-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "route"
    Resource = "route_table"
  }
}

################################################################################
# Public Route Table Association
################################################################################
resource "aws_route_table_association" "rta_public" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.public.*.id,
    count.index,
  )
  route_table_id = aws_route_table.public.id
}

################################################################################
# Database Route Table Association
################################################################################
resource "aws_route_table_association" "rta_database" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.database.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

################################################################################
# Control Pane Route Table Association
################################################################################
resource "aws_route_table_association" "rta_cp" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.cp.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

################################################################################
# Services Route Table Association
################################################################################
resource "aws_route_table_association" "rta_svcs" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.svcs.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

################################################################################
# Workers Route Table Association
################################################################################
resource "aws_route_table_association" "rta_worker" {
  count = var.az_count
  subnet_id = element(
    aws_subnet.worker.*.id,
    count.index,
  )
  route_table_id = aws_route_table.private.id
}

################################################################################
# NAT Gateway
################################################################################
resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.nat.id
  subnet_id         = aws_subnet.public[0].id
  connectivity_type = "public"

  tags = {
    Name     = "ngw-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "ngw"
    Resource = "ngw"
  }
}

resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name     = "ngw-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "eip"
    Resource = "eip"
  }
}

################################################################################
# Internet Gateway
################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "igw-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "igw"
    Resource = "igw"
  }
}
