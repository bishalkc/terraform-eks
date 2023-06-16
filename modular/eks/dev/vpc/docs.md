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
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | AZ count declaration | `number` | `3` | no |
| <a name="input_base_cidr"></a> [base\_cidr](#input\_base\_cidr) | Base CIDR for VPC | `string` | `"10.100.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cp"></a> [cp](#output\_cp) | CP Subnets |
| <a name="output_database"></a> [database](#output\_database) | Database Subnets |
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | EIP ID |
| <a name="output_eip_public_ip"></a> [eip\_public\_ip](#output\_eip\_public\_ip) | Public Elastic IP |
| <a name="output_igw_vpc_arn"></a> [igw\_vpc\_arn](#output\_igw\_vpc\_arn) | IGW ARN |
| <a name="output_igw_vpc_id"></a> [igw\_vpc\_id](#output\_igw\_vpc\_id) | IGW ID |
| <a name="output_ngw_allocation_id"></a> [ngw\_allocation\_id](#output\_ngw\_allocation\_id) | NAT Gateway Allocation ID |
| <a name="output_ngw_id"></a> [ngw\_id](#output\_ngw\_id) | NAT Gatway ID |
| <a name="output_public"></a> [public](#output\_public) | Public Subnets |
| <a name="output_route_table_private_arn"></a> [route\_table\_private\_arn](#output\_route\_table\_private\_arn) | Route Table Private ARN |
| <a name="output_route_table_private_id"></a> [route\_table\_private\_id](#output\_route\_table\_private\_id) | Route Table Private ID |
| <a name="output_route_table_public_arn"></a> [route\_table\_public\_arn](#output\_route\_table\_public\_arn) | Route Table Public ARN |
| <a name="output_route_table_public_id"></a> [route\_table\_public\_id](#output\_route\_table\_public\_id) | Route Table Public ID |
| <a name="output_svcs"></a> [svcs](#output\_svcs) | Services Subnets |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | VPC ARN |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | VPC Cidr Block |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_worker"></a> [worker](#output\_worker) | Worker Subnets |
<!-- END_TF_DOCS -->
