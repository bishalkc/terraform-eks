<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

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
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_generated_ipv6_cidr_block"></a> [assign\_generated\_ipv6\_cidr\_block](#input\_assign\_generated\_ipv6\_cidr\_block) | Assign auto generated ipv6 CIDR Block | `bool` | `true` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_az_count"></a> [az\_count](#input\_az\_count) | n/a | `number` | n/a | yes |
| <a name="input_base_cidr"></a> [base\_cidr](#input\_base\_cidr) | Base CIDR for VPC | `string` | n/a | yes |
| <a name="input_cp_subnet_cidr"></a> [cp\_subnet\_cidr](#input\_cp\_subnet\_cidr) | CIDR block for control plane subnets | `string` | n/a | yes |
| <a name="input_database_subnet_cidr"></a> [database\_subnet\_cidr](#input\_database\_subnet\_cidr) | CIDR block for database subnets | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR block for public subnets | `string` | n/a | yes |
| <a name="input_svcs_subnet_cidr"></a> [svcs\_subnet\_cidr](#input\_svcs\_subnet\_cidr) | CIDR block for services subnets | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on the bucket. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Project Tenant | `string` | `"demo"` | no |
| <a name="input_worker_subnet_cidr"></a> [worker\_subnet\_cidr](#input\_worker\_subnet\_cidr) | CIDR block for worker subnets | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cp"></a> [cp](#output\_cp) | n/a |
| <a name="output_database"></a> [database](#output\_database) | n/a |
| <a name="output_eip_id"></a> [eip\_id](#output\_eip\_id) | # ELASTIC IP (vpc) NAT GATEWAYS - Outputs |
| <a name="output_eip_public_ip"></a> [eip\_public\_ip](#output\_eip\_public\_ip) | n/a |
| <a name="output_igw_vpc_arn"></a> [igw\_vpc\_arn](#output\_igw\_vpc\_arn) | # IGW (vpc) Outputs |
| <a name="output_igw_vpc_id"></a> [igw\_vpc\_id](#output\_igw\_vpc\_id) | n/a |
| <a name="output_ngw_allocation_id"></a> [ngw\_allocation\_id](#output\_ngw\_allocation\_id) | n/a |
| <a name="output_ngw_id"></a> [ngw\_id](#output\_ngw\_id) | # NAT Gateways (vpc) Outputs |
| <a name="output_public"></a> [public](#output\_public) | # SUBNETS (vpc)  - Outputs |
| <a name="output_route_table_private_arn"></a> [route\_table\_private\_arn](#output\_route\_table\_private\_arn) | # ROUTE TABLES (vpc) PRIVATE - Outputs |
| <a name="output_route_table_private_id"></a> [route\_table\_private\_id](#output\_route\_table\_private\_id) | n/a |
| <a name="output_route_table_public_arn"></a> [route\_table\_public\_arn](#output\_route\_table\_public\_arn) | # ROUTE TABLES (vpc) PUBLIC - Outputs |
| <a name="output_route_table_public_id"></a> [route\_table\_public\_id](#output\_route\_table\_public\_id) | n/a |
| <a name="output_svcs"></a> [svcs](#output\_svcs) | n/a |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | # VPC Outputs |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_worker"></a> [worker](#output\_worker) | n/a |
<!-- END_TF_DOCS -->
