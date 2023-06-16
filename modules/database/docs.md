<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.rds_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.rds_paramgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.rds_subnetgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_3306_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.rds_admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_database"></a> [create\_database](#input\_create\_database) | Creates Database | `bool` | `false` | no |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | Define Database Instance Type | `string` | `"db.t3.medium"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Define Database port number | `number` | `3306` | no |
| <a name="input_db_subnet_ids"></a> [db\_subnet\_ids](#input\_db\_subnet\_ids) | Define Database Subnets | `list(string)` | n/a | yes |
| <a name="input_db_type"></a> [db\_type](#input\_db\_type) | Define Database Type | `string` | `"mariadb"` | no |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | Define Database Version | `string` | `"10.5.0"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_sg_bastion_public_id"></a> [sg\_bastion\_public\_id](#input\_sg\_bastion\_public\_id) | Define Bastion SG ID | `string` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Project Tenant | `string` | `"demo"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Define VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_rds_arn"></a> [sg\_rds\_arn](#output\_sg\_rds\_arn) | ARN for RDS Security Group |
| <a name="output_sg_rds_id"></a> [sg\_rds\_id](#output\_sg\_rds\_id) | ID for RDS Security Group |
<!-- END_TF_DOCS -->
