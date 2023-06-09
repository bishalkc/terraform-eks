<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.1.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ../../../modules/eks | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_keypair_name"></a> [bastion\_keypair\_name](#output\_bastion\_keypair\_name) | Bastion KeyPair Name |
| <a name="output_bastion_private_sg_arn"></a> [bastion\_private\_sg\_arn](#output\_bastion\_private\_sg\_arn) | Bastion Private SG ARN |
| <a name="output_bastion_private_sg_id"></a> [bastion\_private\_sg\_id](#output\_bastion\_private\_sg\_id) | Bastion Private SG ID |
| <a name="output_bastion_public_sg_arn"></a> [bastion\_public\_sg\_arn](#output\_bastion\_public\_sg\_arn) | Bastion Public SG ARN |
| <a name="output_bastion_public_sg_id"></a> [bastion\_public\_sg\_id](#output\_bastion\_public\_sg\_id) | Bastion Public SG ID |
| <a name="output_cloudwatch_loggroup_eks_arn"></a> [cloudwatch\_loggroup\_eks\_arn](#output\_cloudwatch\_loggroup\_eks\_arn) | ARN of Cloudwatch log group for eks |
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | ECR URL |
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | ARN of EKS Cluster |
| <a name="output_eks_cluster_ca_certificate"></a> [eks\_cluster\_ca\_certificate](#output\_eks\_cluster\_ca\_certificate) | Platform Version of EKS Cluster |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | Endpoint of EKS Cluster |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | ARN of EKS Cluster |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | ARN of EKS Cluster |
| <a name="output_eks_cluster_platform_version"></a> [eks\_cluster\_platform\_version](#output\_eks\_cluster\_platform\_version) | ARN of EKS Cluster |
| <a name="output_eks_cluster_status"></a> [eks\_cluster\_status](#output\_eks\_cluster\_status) | Status of EKS Cluster |
| <a name="output_iam_cluster_role_arn"></a> [iam\_cluster\_role\_arn](#output\_iam\_cluster\_role\_arn) | ARN of EKS IAM Role |
| <a name="output_iam_cluster_role_id"></a> [iam\_cluster\_role\_id](#output\_iam\_cluster\_role\_id) | ID of EKS IAM Role |
| <a name="output_iam_cluster_role_name"></a> [iam\_cluster\_role\_name](#output\_iam\_cluster\_role\_name) | Name of EKS IAM Role |
| <a name="output_iam_worker_role_arn"></a> [iam\_worker\_role\_arn](#output\_iam\_worker\_role\_arn) | ARN of EKS worker 1 IAM Role |
| <a name="output_iam_worker_role_id"></a> [iam\_worker\_role\_id](#output\_iam\_worker\_role\_id) | ID of EKS worker 1 IAM Role |
| <a name="output_iam_worker_role_name"></a> [iam\_worker\_role\_name](#output\_iam\_worker\_role\_name) | Name of EKS worker 1 IAM Role |
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | ARN of EKS KMS Alias for EKS Key |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | ARN of EKS KMS |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | Key ID of EKS KMS Key |
| <a name="output_launch_worker_t3micro_lt_arn"></a> [launch\_worker\_t3micro\_lt\_arn](#output\_launch\_worker\_t3micro\_lt\_arn) | ARN  of Launch Template for EKS-1 NodeGroup |
| <a name="output_launch_worker_t3micro_lt_id"></a> [launch\_worker\_t3micro\_lt\_id](#output\_launch\_worker\_t3micro\_lt\_id) | ID of Launch Template for EKS-1 NodeGroup |
| <a name="output_launch_worker_t3micro_lt_latest_version"></a> [launch\_worker\_t3micro\_lt\_latest\_version](#output\_launch\_worker\_t3micro\_lt\_latest\_version) | Latest Version of Launch Template for EKS-1 NodeGroup |
| <a name="output_node_group_arn"></a> [node\_group\_arn](#output\_node\_group\_arn) | ARN of EKS NodeGroup |
| <a name="output_node_group_id"></a> [node\_group\_id](#output\_node\_group\_id) | ID of EKS NodeGroup |
| <a name="output_node_group_status"></a> [node\_group\_status](#output\_node\_group\_status) | Status of EKS NodeGroup |
| <a name="output_oidc_arn"></a> [oidc\_arn](#output\_oidc\_arn) | ARN of EKS OIDC |
| <a name="output_oidc_url"></a> [oidc\_url](#output\_oidc\_url) | URL of EKS OIDC |
<!-- END_TF_DOCS -->
