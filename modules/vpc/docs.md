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
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rta_cp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rta_database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rta_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rta_svcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rta_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.cp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.svcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_generated_ipv6_cidr_block"></a> [assign\_generated\_ipv6\_cidr\_block](#input\_assign\_generated\_ipv6\_cidr\_block) | Assign auto generated ipv6 CIDR Block | `bool` | `true` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | Set Number of AZ's | `number` | n/a | yes |
| <a name="input_base_cidr"></a> [base\_cidr](#input\_base\_cidr) | Base CIDR for VPC | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cp"></a> [cp](#output\_cp) | VPC Control Pane Subnets |
| <a name="output_database"></a> [database](#output\_database) | VPC Database Subnets |
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | VPC Elastic NAT ID |
| <a name="output_eip_public_ip"></a> [eip\_public\_ip](#output\_eip\_public\_ip) | VPC Elastic NAT PUBLIC IP |
| <a name="output_igw_vpc_arn"></a> [igw\_vpc\_arn](#output\_igw\_vpc\_arn) | IGW ARN |
| <a name="output_igw_vpc_id"></a> [igw\_vpc\_id](#output\_igw\_vpc\_id) | IGW ID |
| <a name="output_ngw_allocation_id"></a> [ngw\_allocation\_id](#output\_ngw\_allocation\_id) | VPC NAT Gateway Allocation ID |
| <a name="output_ngw_id"></a> [ngw\_id](#output\_ngw\_id) | VPC NAT Gateway ID |
| <a name="output_public"></a> [public](#output\_public) | VPC Public Subnets |
| <a name="output_route_table_private_arn"></a> [route\_table\_private\_arn](#output\_route\_table\_private\_arn) | VPC Private Route Table ARN |
| <a name="output_route_table_private_id"></a> [route\_table\_private\_id](#output\_route\_table\_private\_id) | VPC Private Route Table ID |
| <a name="output_route_table_public_arn"></a> [route\_table\_public\_arn](#output\_route\_table\_public\_arn) | VPC Public Route Table ARN |
| <a name="output_route_table_public_id"></a> [route\_table\_public\_id](#output\_route\_table\_public\_id) | VPC Public Route Table ID |
| <a name="output_svcs"></a> [svcs](#output\_svcs) | VPC Services Subnet |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | VPC ARN |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | VPC CIDR BLOCK |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_worker"></a> [worker](#output\_worker) | VPC Worker/Node Subnet |
<!-- END_TF_DOCS -->
