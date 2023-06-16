resource "aws_ecr_repository" "ecr" {
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

resource "aws_ecr_repository_policy" "ecr" {
  repository = aws_ecr_repository.ecr.name
  policy     = file("../policies/ecr_repository_policy.json")
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name

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
