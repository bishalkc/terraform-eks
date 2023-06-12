resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "private-route-table-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "route"
    Resource = "route_table"
  }
}

# resource "aws_route_table" "private_2" {
#   vpc_id = aws_vpc.sandbox.id

#   tags = merge(
#     {
#       Name = "private-route-table-2"
#       Tier = "private"
#     },
#     local.common_tags
#   )
# }
