################################################################################
# ECR
################################################################################
resource "aws_ecr_repository" "ecr" {
  count = local.create_ecr ? 1 : 0

  name = "${local.project}-${local.environment}"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name     = "ecr-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "ecr"
    Resource = "ecr"
  }
}

################################################################################
# ECR POLICY
################################################################################
resource "aws_ecr_repository_policy" "ecr" {
  count = local.create_ecr ? 1 : 0

  repository = aws_ecr_repository.ecr[count.index].name
  policy     = file("../../../modules/policies/ecr_repository_policy.json")
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  count = local.create_ecr ? 1 : 0

  repository = aws_ecr_repository.ecr[count.index].name

  policy = <<EOF
{
  "rules": [
    {
      "action": {
        "type": "expire"
      },
      "selection": {
        "countType": "imageCountMoreThan",
        "countNumber": 4,
        "tagStatus": "untagged"
      },
      "description": "Delete Old Images that are untagged",
      "rulePriority": 1
    }
  ]
}
EOF

}
