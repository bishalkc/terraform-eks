resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name     = "public-route-table-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "route"
    Resource = "route_table"
  }
}


## ADD 2 more for production and actual clients

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.vpc.id

#   tags = merge(
#     {
#       Name = "public-${local.project}-${local.environment}"
#       Tier = "public"
#     },
#     local.common_tags
#   )
# }
