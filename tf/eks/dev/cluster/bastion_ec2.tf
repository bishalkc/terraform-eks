data "template_file" "public" {
  template = file("${path.module}/files/bastion_userdata.tpl")

  vars = {
    hostname = "${local.project}-${local.environment}.svcs.local"
    fqdn     = "${local.project}-${local.environment}.svcs.local"
    version  = local.eks.version
  }
}

resource "aws_key_pair" "bastion" {
  key_name   = "bastion-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCt+ReNnPHoKgSLpQCdZQ8kOn5rpkICTHskQEezhyvu/27e6XzZ/8QUtBR6rdN+pjRbcRgP9lRK7xONamEgvRYBWQDaRBirgiEPEMLZC30a/ouDJlwnJdppBHRB0VV3Dilg1kdg1y1wDXnTGA0yZeBwIt8NXDHrugYnA1SBbGRHSKaFFK5WelyTbLO2q53sipF+8PvPw847Yz/8zIAeYXnMZJSSKRVTRBoDsFjx1jQo+mfsXc7pZ4JJ+Eyq926auuIAKHkFUrIaBg8FTP/3lyIB8Cd2IwH7AM97oZSUYB6R0RAOo6hEiXNarozkjks2jt4ZRT9pym4yxzS9a/jRhb5wa7oCUQyQXinzdaQIITVm767+Wl32Q9v/q9NG9uOBsKRiMDnjvt6idsDMEakBRP2lPj2svnSRnFe+2PQjJECShRM9RG4zfrLOENA0c7TEG0x9cH4xl1P+EeZcVne1IzYIZOL942haXzgIkwnLOxnD3VzrAf35YOvBHzBsE5EUxfE= bkc@bishals-mbp.lan"
}

resource "aws_instance" "bastion_public" {

  ami                         = data.aws_ami.bastion_amazon_linux_2_latest.id
  associate_public_ip_address = true
  disable_api_termination     = false
  iam_instance_profile        = aws_iam_instance_profile.public_bastion_ip.name
  instance_type               = local.bastion.instance_type
  key_name                    = aws_key_pair.bastion.key_name
  subnet_id                   = local.subnet_public
  user_data                   = data.template_file.public.rendered
  vpc_security_group_ids      = [aws_security_group.bastion_public.id]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name      = "/dev/xvda-${local.project}-${local.environment}"
      Tier      = "primary"
      Encrypted = "true"
      Role      = "volume"
      Tier      = "private"
      Resource  = "ebs"
    }
  }


  tags = {
    Name      = "${local.project}-${local.environment}"
    Host_Type = "static"
    Tier      = "public"
    Role      = "instance"
    Resource  = "ec2"
  }

  #To get eks cluster config: aws eks update-kubeconfig --name ccp-sandbox-eks-1 --kubeconfig ~/.kube/config --region us-east-1

}

# resource "aws_instance" "bastion_private" {

#   ami                         = data.aws_ami.amazon_linux_2_latest.id
#   associate_public_ip_address = false
#   disable_api_termination     = false
#   iam_instance_profile        = aws_iam_instance_profile.private_bastion_ip.name
#   instance_type               = local.instance_type
#   key_name                    = "ccp-${local.project_name}-keypair"
#   subnet_id                   = local.subnet_privat_svc_id
#   vpc_security_group_ids      = [aws_security_group.bastion_private.id]
#   user_data                   = file("files/userdata-private.tpl")

#   timeouts {
#     create = "15m"
#     update = "15m"
#     delete = "15m"
#   }

#   root_block_device {
#     delete_on_termination = true
#     encrypted             = true

#     tags = {
#       Name      = "/dev/xvda_${local.project_name}-private.svc.ccp.gsa.local"
#       Type      = "primary"
#       Encrypted = "true"
#     }
#   }

#   lifecycle {
#     ignore_changes = [user_data, ami]
#   }

#   tags = merge(
#     {
#       Name      = "${local.project_name}-private.svc.ccp.gsa.local"
#       Host_Type = "static"
#       Tier      = "private"
#     },
#     local.common_tags
#   )

#   #To get eks cluster config: aws eks update-kubeconfig --name ccp-sandbox-eks-1 --kubeconfig ~/.kube/config --region us-east-1

# }
