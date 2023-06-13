<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.ecr_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/resources/ecr_repository_policy) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.2.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecr"></a> [create\_ecr](#input\_create\_ecr) | Creates ECR | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Project Tenant | `string` | `"demo"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr"></a> [ecr](#output\_ecr) | ECR URL |
<!-- END_TF_DOCS -->
