resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 10, count.index)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name                     = "public-subnet-${local.project}-${local.environment}-${count.index}"
    Tier                     = "public"
    Role                     = "public"
    Resource                 = "subnet"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "database" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.base_cidr, 11, count.index + 8)
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name                              = "database-subnet-${local.project}-${local.environment}-${count.index}"
    Tier                              = "private"
    Role                              = "database"
    Resource                          = "subnet"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

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
    "kubernetes.io/role/internal-elb" = "1"
  }
}

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
    "kubernetes.io/role/internal-elb" = "1"
  }
}

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
    "kubernetes.io/role/internal-elb" = "1"
  }
}
