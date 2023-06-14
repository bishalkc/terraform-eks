<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.3.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_cluster.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.private_bastion_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.public_bastion_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_openid_connect_provider.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.cluster_role_kms_readwrite_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.private_bastion_eks_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.public_bastion_eks_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.private_bastion_eks_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.public_bastion_eks_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.private_bastion_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.public_bastion_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.worker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.amazon_ec2_container_registry_readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_role_amazon_eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_role_amazon_eks_vpc_resource_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_role_kms_readwrite](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_role_amazon_ec2_container_registry_readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_role_amazon_eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.bastion_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.bastion_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.worker_t3micro_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.bastion_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bastion_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_ingress_private_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_ingress_public_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_22_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_ingress_22_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.amazon_linux_2_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.bastion_amazon_linux_2_latest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_group.eks_auto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [template_file.public](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [tls_certificate.oidc](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | Define bastion instance type | `string` | `"t3.micro"` | no |
| <a name="input_cp_subnet_ids"></a> [cp\_subnet\_ids](#input\_cp\_subnet\_ids) | Define CP Subnet Ids | `list(string)` | n/a | yes |
| <a name="input_create_private_bastion"></a> [create\_private\_bastion](#input\_create\_private\_bastion) | Creates Private Bastion | `bool` | `false` | no |
| <a name="input_create_public_bastion"></a> [create\_public\_bastion](#input\_create\_public\_bastion) | Creates Public Bastion | `bool` | `true` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of EKS Cluster | `string` | n/a | yes |
| <a name="input_eks_instance_type"></a> [eks\_instance\_type](#input\_eks\_instance\_type) | Define Node Instance Type | `string` | `"t3.medium"` | no |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | Define EKS Version | `string` | `"1.27"` | no |
| <a name="input_eks_volume_size"></a> [eks\_volume\_size](#input\_eks\_volume\_size) | Define Volume Size | `number` | `20` | no |
| <a name="input_eks_volume_type"></a> [eks\_volume\_type](#input\_eks\_volume\_type) | Define Volume Type | `string` | `"gp3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Define KMS Key ARN | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_vpc_private_subnet"></a> [vpc\_private\_subnet](#input\_vpc\_private\_subnet) | Creates Public Subnet for Bastion | `string` | n/a | yes |
| <a name="input_vpc_public_subnet"></a> [vpc\_public\_subnet](#input\_vpc\_public\_subnet) | Creates Public Subnet for Bastion | `string` | n/a | yes |
| <a name="input_worker_subnet_ids"></a> [worker\_subnet\_ids](#input\_worker\_subnet\_ids) | Define Worker Subnet Ids | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_keypair_name"></a> [bastion\_keypair\_name](#output\_bastion\_keypair\_name) | Bastion KeyPair Name |
| <a name="output_bastion_private_sg_arn"></a> [bastion\_private\_sg\_arn](#output\_bastion\_private\_sg\_arn) | Bastion Private SG ARN |
| <a name="output_bastion_private_sg_id"></a> [bastion\_private\_sg\_id](#output\_bastion\_private\_sg\_id) | Bastion Private SG ID |
| <a name="output_bastion_public_sg_arn"></a> [bastion\_public\_sg\_arn](#output\_bastion\_public\_sg\_arn) | Bastion Public SG ARN |
| <a name="output_bastion_public_sg_id"></a> [bastion\_public\_sg\_id](#output\_bastion\_public\_sg\_id) | Bastion Public SG ID |
| <a name="output_cloudwatch_loggroup_eks_arn"></a> [cloudwatch\_loggroup\_eks\_arn](#output\_cloudwatch\_loggroup\_eks\_arn) | ARN of Cloudwatch log group for eks |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | ARN of EKS Cluster 1 |
| <a name="output_eks_cluster_ca_certificate"></a> [eks\_cluster\_ca\_certificate](#output\_eks\_cluster\_ca\_certificate) | ARN of EKS Cluster 1 |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | Endpoint of EKS Cluster 1 |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | ARN of EKS Cluster 1 |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | ARN of EKS Cluster 1 |
| <a name="output_eks_cluster_platform_version"></a> [eks\_cluster\_platform\_version](#output\_eks\_cluster\_platform\_version) | Platform Version of EKS Cluster 1 |
| <a name="output_eks_cluster_status"></a> [eks\_cluster\_status](#output\_eks\_cluster\_status) | Status of EKS Cluster 1 |
| <a name="output_iam_cluster_role_arn"></a> [iam\_cluster\_role\_arn](#output\_iam\_cluster\_role\_arn) | ARN of EKS IAM Role |
| <a name="output_iam_cluster_role_id"></a> [iam\_cluster\_role\_id](#output\_iam\_cluster\_role\_id) | ID of EKS IAM Role |
| <a name="output_iam_cluster_role_name"></a> [iam\_cluster\_role\_name](#output\_iam\_cluster\_role\_name) | Name of EKS IAM Role |
| <a name="output_iam_worker_role_arn"></a> [iam\_worker\_role\_arn](#output\_iam\_worker\_role\_arn) | ARN of EKS worker 1 IAM Role |
| <a name="output_iam_worker_role_id"></a> [iam\_worker\_role\_id](#output\_iam\_worker\_role\_id) | ID of EKS worker 1 IAM Role |
| <a name="output_iam_worker_role_name"></a> [iam\_worker\_role\_name](#output\_iam\_worker\_role\_name) | Name of EKS worker 1 IAM Role |
| <a name="output_launch_worker_t3micro_lt_arn"></a> [launch\_worker\_t3micro\_lt\_arn](#output\_launch\_worker\_t3micro\_lt\_arn) | ARN  of Launch Template for EKS-1 NodeGroup-1 |
| <a name="output_launch_worker_t3micro_lt_id"></a> [launch\_worker\_t3micro\_lt\_id](#output\_launch\_worker\_t3micro\_lt\_id) | ID of Launch Template for EKS-1 NodeGroup-1 |
| <a name="output_launch_worker_t3micro_lt_latest_version"></a> [launch\_worker\_t3micro\_lt\_latest\_version](#output\_launch\_worker\_t3micro\_lt\_latest\_version) | Latest Version of Launch Template for EKS-1 NodeGroup-1 |
| <a name="output_node_group_arn"></a> [node\_group\_arn](#output\_node\_group\_arn) | ARN of EKS NodeGroup |
| <a name="output_node_group_id"></a> [node\_group\_id](#output\_node\_group\_id) | ID of EKS NodeGroup |
| <a name="output_node_group_status"></a> [node\_group\_status](#output\_node\_group\_status) | Status of EKS NodeGroup |
| <a name="output_oidc_arn"></a> [oidc\_arn](#output\_oidc\_arn) | ARN of EKS OIDC |
| <a name="output_oidc_url"></a> [oidc\_url](#output\_oidc\_url) | URL of EKS OIDC |
<!-- END_TF_DOCS -->
