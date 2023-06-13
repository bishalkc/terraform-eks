<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secretmanager"></a> [secretmanager](#module\_secretmanager) | ../../../modules/secretmanager | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [terraform_remote_state.eks](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_secret_manager_arn"></a> [app\_secret\_manager\_arn](#output\_app\_secret\_manager\_arn) | ARN of App Secret Manager |
| <a name="output_app_secret_manager_id"></a> [app\_secret\_manager\_id](#output\_app\_secret\_manager\_id) | ID of Database Secret Manager |
| <a name="output_database_secret_manager_arn"></a> [database\_secret\_manager\_arn](#output\_database\_secret\_manager\_arn) | ARN of Database Secret Manager |
| <a name="output_database_secret_manager_id"></a> [database\_secret\_manager\_id](#output\_database\_secret\_manager\_id) | ID of Database Secret Manager |
<!-- END_TF_DOCS -->
