resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${local.project}-${local.environment}/cluster"
  retention_in_days = 14

  tags = {
    Name     = "/aws/eks/${local.project}-${local.environment}/cluster"
    Tier     = "private"
    Role     = "logs"
    Resource = "cloud_watch"
  }
}