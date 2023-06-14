<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret_string](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_secret_app"></a> [create\_secret\_app](#input\_create\_secret\_app) | Creates Secret Manager for storing App | `bool` | `false` | no |
| <a name="input_create_secret_database"></a> [create\_secret\_database](#input\_create\_secret\_database) | Creates Secret Manager for storing Database | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_framework"></a> [framework](#input\_framework) | App framework | `string` | `"demo"` | no |
| <a name="input_kms_id"></a> [kms\_id](#input\_kms\_id) | KMS ID for encryption | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Adding prefix to Secret Manager name | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | Secrets to populate | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_secret_manager_arn"></a> [app\_secret\_manager\_arn](#output\_app\_secret\_manager\_arn) | ARN of App Secret Manager |
| <a name="output_app_secret_manager_id"></a> [app\_secret\_manager\_id](#output\_app\_secret\_manager\_id) | ID of Database Secret Manager |
| <a name="output_database_secret_manager_arn"></a> [database\_secret\_manager\_arn](#output\_database\_secret\_manager\_arn) | ARN of Database Secret Manager |
| <a name="output_database_secret_manager_id"></a> [database\_secret\_manager\_id](#output\_database\_secret\_manager\_id) | ID of Database Secret Manager |
<!-- END_TF_DOCS -->
