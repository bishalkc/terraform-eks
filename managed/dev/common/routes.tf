resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


### Add different for multiple NGW

# resource "aws_route" "public_1" {
#   route_table_id         = aws_route_table.public_2.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id

# }

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

## ADD different for multiple NGW

# resource "aws_route" "private" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.ngw.id
#   timeouts {
#     create = "10m"
#     update = "10m"
#     delete = "10m"
#   }

# }
