<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ../../../modules/ecr | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | ../../../modules/kms | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | ECR URL |
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | ARN of EKS KMS Alias for EKS Key |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of EKS KMS Key |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | Key ID of EKS KMS Key |
<!-- END_TF_DOCS -->
