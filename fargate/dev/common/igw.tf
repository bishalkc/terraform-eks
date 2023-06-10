resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "igw-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "igw"
    Resource = "igw"
  }
}
