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
| [aws_eks_addon.cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_policy.ebs_kms_readwrite_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ebs_role_kms_grant_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.addon_cni_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.addon_ebs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.addon_cni_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.addon_ebs_role_kms_grant_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.addon_ebs_role_kms_readright_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.addon_ebs_role_servicerole_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.addon_cni_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.addon_ebs_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_oidc_arn"></a> [aws\_oidc\_arn](#input\_aws\_oidc\_arn) | ARN of AWS OIDC | `string` | n/a | yes |
| <a name="input_aws_oidc_url"></a> [aws\_oidc\_url](#input\_aws\_oidc\_url) | URL of OIDC | `string` | n/a | yes |
| <a name="input_cni_addon_name"></a> [cni\_addon\_name](#input\_cni\_addon\_name) | Define CNI Addon Name | `string` | `"vpc-cni"` | no |
| <a name="input_cni_addon_version"></a> [cni\_addon\_version](#input\_cni\_addon\_version) | Define CNI Addon Version | `string` | `"v1.12.6-eksbuild.2"` | no |
| <a name="input_ebs_addon_name"></a> [ebs\_addon\_name](#input\_ebs\_addon\_name) | Define EBS Addon Name | `string` | `"aws-ebs-csi-driver"` | no |
| <a name="input_ebs_addon_version"></a> [ebs\_addon\_version](#input\_ebs\_addon\_version) | Define EBS Addon Version | `string` | `"v1.19.0-eksbuild.2"` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_enable_cni"></a> [enable\_cni](#input\_enable\_cni) | Enable CNI Addon | `bool` | n/a | yes |
| <a name="input_enable_ebs"></a> [enable\_ebs](#input\_enable\_ebs) | Enable EBS Addon | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addon_vpc_cni_arn"></a> [addon\_vpc\_cni\_arn](#output\_addon\_vpc\_cni\_arn) | ARN of EKS VPC-CNI Addon |
| <a name="output_addon_vpc_cni_id"></a> [addon\_vpc\_cni\_id](#output\_addon\_vpc\_cni\_id) | ID of EKS VPC-CNI Addon |
| <a name="output_addon_vpc_ebs_arn"></a> [addon\_vpc\_ebs\_arn](#output\_addon\_vpc\_ebs\_arn) | ARN of EKS AWS-EBS Addon |
| <a name="output_addon_vpc_ebs_id"></a> [addon\_vpc\_ebs\_id](#output\_addon\_vpc\_ebs\_id) | ID of EKS AWS-EBS Addon |
<!-- END_TF_DOCS -->
