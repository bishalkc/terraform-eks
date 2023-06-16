# Locals for common
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_ami" "bastion_amazon_linux_2_latest" {

  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  aws_region     = data.aws_region.current.name
  account_number = data.aws_caller_identity.current.account_id
  my_ip          = chomp(data.http.myip.response_body)
}
