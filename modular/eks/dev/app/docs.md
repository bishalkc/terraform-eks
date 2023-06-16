<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secretmanager"></a> [secretmanager](#module\_secretmanager) | ../../../modules/secretmanager | n/a |
| <a name="module_ssm"></a> [ssm](#module\_ssm) | ../../../modules/ssm | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_secret_manager_arn"></a> [app\_secret\_manager\_arn](#output\_app\_secret\_manager\_arn) | ARN of App Secret Manager |
| <a name="output_app_secret_manager_id"></a> [app\_secret\_manager\_id](#output\_app\_secret\_manager\_id) | ID of Database Secret Manager |
| <a name="output_database_secret_manager_arn"></a> [database\_secret\_manager\_arn](#output\_database\_secret\_manager\_arn) | ARN of Database Secret Manager |
| <a name="output_database_secret_manager_id"></a> [database\_secret\_manager\_id](#output\_database\_secret\_manager\_id) | ID of Database Secret Manager |
| <a name="output_ssm_parameter_arn"></a> [ssm\_parameter\_arn](#output\_ssm\_parameter\_arn) | ARN of Parameter Store |
<!-- END_TF_DOCS -->
