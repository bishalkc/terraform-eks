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
| [aws_efs_file_system.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.zone-a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.zone-b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_efs_mount_target.zone-c](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecr"></a> [create\_ecr](#input\_create\_ecr) | Creates ECR | `bool` | `true` | no |
| <a name="input_create_efs"></a> [create\_efs](#input\_create\_efs) | Is it Fargate | `bool` | `false` | no |
| <a name="input_eks_security_group_id"></a> [eks\_security\_group\_id](#input\_eks\_security\_group\_id) | Auto generated EKS Security Group ID | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_worker_subnet_ids"></a> [worker\_subnet\_ids](#input\_worker\_subnet\_ids) | Define Worker Subnet Ids | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_arn"></a> [efs\_arn](#output\_efs\_arn) | ECR URL |
| <a name="output_efs_az_id"></a> [efs\_az\_id](#output\_efs\_az\_id) | ECR URL |
| <a name="output_efs_domain_name"></a> [efs\_domain\_name](#output\_efs\_domain\_name) | ECR URL |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | ECR URL |
<!-- END_TF_DOCS -->
