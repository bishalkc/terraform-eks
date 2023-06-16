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
| [aws_ssm_parameter.param](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_type"></a> [data\_type](#input\_data\_type) | The data\_type of the parameter. Valid values: text and aws:ec2:image for AMI format, see the Native parameter support for Amazon Machine Image IDs ( https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html ) | `string` | `"text"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the parameter. | `string` | `"Parameter Stores"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_framework"></a> [framework](#input\_framework) | App framework | `string` | `"demo"` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | KMS ID for encryption | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for SSM Parameter | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | The type of the parameter. Valid types are String, StringList and SecureString | `string` | `"Standard"` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the parameter. Valid types are String, StringList and SecureString | `string` | `"SecureString"` | no |
| <a name="input_value"></a> [value](#input\_value) | The value of the parameter. This value is always marked as sensitive in the Terraform plan output, regardless of type. In Terraform CLI version 0.15 and later, this may require additional configuration handling for certain scenarios. For more information, see the Terraform v0.15 Upgrade Guide.The KMS key id or arn for encrypting a SecureString. ( https://www.terraform.io/upgrade-guides/0-15.html?&_ga=2.264038603.670901932.1623631883-573757115.1588460856#sensitive-output-values ) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssm_parameter_arn"></a> [ssm\_parameter\_arn](#output\_ssm\_parameter\_arn) | ARN of Parameter Store |
<!-- END_TF_DOCS -->
