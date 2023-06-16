resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.eip.id
  subnet_id         = aws_subnet.public[0].id
  connectivity_type = "public"

  tags = {
    Name     = "ngw-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "ngw"
    Resource = "ngw"
  }
}

# resource "aws_nat_gateway" "ngw_2" {
#   allocation_id     = aws_eip.ngw_2.id
#   subnet_id         = aws_subnet.public_subnet_2.id
#   connectivity_type = "public"

#   tags = merge(
#     {
#       Name = "ngw-${local.project}-${local.environment}"
#       Tier = "private"
#     },
#     local.common_tags
#   )

# }
