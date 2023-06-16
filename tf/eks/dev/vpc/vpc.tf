resource "aws_vpc" "vpc" {
  assign_generated_ipv6_cidr_block = "false"
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
