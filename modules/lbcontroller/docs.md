<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.21.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lb_controller_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lb_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lb_controller_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [kubernetes_service_account_v1.lb_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [aws_iam_policy_document.lb_controrller_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_oidc_arn"></a> [aws\_oidc\_arn](#input\_aws\_oidc\_arn) | ARN of AWS OIDC | `string` | n/a | yes |
| <a name="input_aws_oidc_url"></a> [aws\_oidc\_url](#input\_aws\_oidc\_url) | URL of OIDC | `string` | n/a | yes |
| <a name="input_eks_cluster_ca_certificate"></a> [eks\_cluster\_ca\_certificate](#input\_eks\_cluster\_ca\_certificate) | EKS Cluster Certificates | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_enable_lb_controller"></a> [enable\_lb\_controller](#input\_enable\_lb\_controller) | Create LB Controller | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Project Environment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project Name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
