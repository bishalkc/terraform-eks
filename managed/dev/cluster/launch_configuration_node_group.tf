## NOTE: EKS Managed Worker Node is currently not compatible with defining Network Interface & IAM Profile Configurations in Launch Template and handles it via the Node Group Resource itself. 12/17/2021
resource "aws_launch_template" "worker_t3micro_lt" {

  name                    = "lt-${local.project}-${local.environment}-worker"
  description             = "Launch Template for Managed Node Groups of ${local.project} ${local.environment} with Instance Type t3.micro"
  image_id                = data.aws_ami.amazon_linux_2_latest.id
  disable_api_termination = true
  ebs_optimized           = false
  instance_type           = local.eks.instance_type
  update_default_version  = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = local.eks.volume_size
      volume_type           = local.eks.volume_type
      delete_on_termination = true
      encrypted             = true
      kms_key_id            = aws_kms_key.kms.arn
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = aws_key_pair.bastion.key_name

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = [
    aws_security_group.bastion_private.id,
    aws_security_group.bastion_public.id,
    aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  ]

  user_data = base64encode(<<-EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
/etc/eks/bootstrap.sh ${aws_eks_cluster.eks.id}

--==MYBOUNDARY==--
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name     = "worker-${local.project}-${local.environment}"
      Tier     = "private"
      Role     = "eks"
      Resource = "ec2"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name      = "/dev/xvda-worker-${local.project}-${local.environment}"
      Encrypted = "true"
      Tier      = "private"
      Role      = "eks"
      Resource  = "volume"
    }
  }

}
