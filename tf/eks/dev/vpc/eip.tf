resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name     = "ngw-${local.project}-${local.environment}"
    Tier     = "public"
    Role     = "eip"
    Resource = "eip"
  }
}

# resource "aws_eip" "ngw_2" {
#   vpc = true

#   tags = merge(
#     {
#       Name = "ngw-2-eip"
#       Tier = "public"
#     },
#     local.common_tags
#   )
# }
