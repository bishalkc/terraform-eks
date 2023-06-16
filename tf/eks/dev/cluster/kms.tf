resource "aws_kms_key" "kms" {
  description         = "KMS Key for ${local.project} ${local.environment}"
  is_enabled          = true
  enable_key_rotation = true
  key_usage           = "ENCRYPT_DECRYPT"
  policy              = data.aws_iam_policy_document.kms_policy.json
  tags = {
    Name     = "kms-key-${local.project}-${local.environment}"
    Tier     = "private"
    Role     = "eks"
    Resource = "kms_keys"
  }
}


resource "aws_kms_alias" "kms" {
  name          = "alias/${local.project}-${local.environment}"
  target_key_id = aws_kms_key.kms.key_id
}


data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid = "EnableIAMUserPermissions"

    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "kms:RevokeGrant"
    ]

    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${local.account_number}:root",
      ]
    }

    resources = [
      "*",
    ]
  }

  statement {
    sid = "SAAccess"

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    effect = "Allow"
    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${local.account_number}:root",
      ]
    }
    resources = [
      "*",
    ]
  }

  statement {
    sid = "AllowUseOfKey"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    effect = "Allow"
    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${local.account_number}:root",
      ]
    }
    resources = [
      "*",
    ]
  }

  statement {
    sid = "AllowAttachmentOfPersistentResources"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]

    effect = "Allow"

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"

      values = [
        "${local.account_number}",
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "ec2.us-east-1.amazonaws.com",
      ]
    }
    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }
    resources = [
      "*",
    ]
  }

}
