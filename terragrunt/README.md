### This repo bootstraps AWS cloud with EKS cluster

#### Supported types of Cluster
- [x] EKS Managed
- [x] EKS Fargate

*NOTE*: `is_fargate` ==true== | ==false== determines the type of cluster


### What it does
- [x] creates vpc
- [x] creates bastion host
- [x] creates eks cluster and supporting roles and infra
- [x] Secret Manager
- [x] SSM Parameter store
- [x] KMS
- [x] creates databases <sup>*<!--- optional --->*</sup>

### Ensure these are installed and configured
* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
* [Precommit](https://pre-commit.com/#install)
* [AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

### *We are using terragrunt to build the infrastructure*
*NOTE:* Learn about [Terragrunt](https://terragrunt.gruntwork.io/)
### *Infra setup in order*
```shell
git clone https://github.com/bishalkc/terraform-eks.git
cd terraform-eks
pre-commit install // make sure you have pre-commit installed
```

#### *Terragrunt fulfills all the depencies specified in child folders*
*The below will create resouces specied on child module in depency order*

:point_down: *Order Resources are create*
- [&check;] VPC
- [&check;] KMS
- [&check;] ECR
- [&check;] Bastion Host
- [&check;] EKS
- [&check;] SSM
- [&check;] Secret Manager
- [&check;] CNI and EBS Addon
- [&check;] LB Controller

#### :heavy_exclamation_mark: *BEFORE RUNNING `TERRAGRUNT` PLEASE UPDATE `{ENV}/env.hcl` AS NEEDED* :heavy_exclamation_mark:

##### :warning: *CREATE ALL RESOURCES AT ONCE*
```shell
cd terragrunt
cd {eks|fargate}
terragrunt run-all apply
```

### :scream_cat: *You can also run individually*

```shell
cd terragrunt/{eks|fargate}
```

##### *VPC/COMMON*
```shell
cd vpc
terragrunt init
terragrunt apply
```

##### *SHARED SEVICES*
```shell
cd shared
cd kms
terragrunt init
terragrunt apply
cd ecr
terragrunt init
terragrunt apply
```

##### *CLUSTER*
```shell
cd eks
terragrunt init
terragrunt apply
```

##### *ADDON* <sup>*<!--- If needed --->*</sup>
```shell
cd addon
terragrunt init
terragrunt apply
```

##### *LB COONTROLLER* <sup>*<!--- If needed --->*</sup>
```shell
cd lbcontroller
terragrunt init
terragrunt apply
```

##### *DATABASE* <sup>*<!--- If needed --->*</sup>
```shell
cd database
terragrunt init
terragrunt apply
```

##### *APP* <sup>*<!--- If needed --->*</sup>
```shell
cd app
terragrunt init
terragrunt apply
```


### :exclamation::exclamation::exclamation:*CLEAN UP*:exclamation::exclamation::exclamation:
#### *CLEAN UP ALL AT ONCE*
```shell
cd terragrunt
terragrunt run-all destroy
```

#### *CLEAN UP ALL INDIVIDUALLY*
##### *APP* <sup>*<!--- If provisioned --->*</sup>
```shell
cd app
terragrunt destroy
```

##### *DATABASE* <sup>*<!--- If provisioned --->*</sup>
```shell
cd database
terragrunt destroy
```

##### *LB CONTROLLER*
```shell
cd lbcontroller
terragrunt destroy
```

##### *ADDON*
```shell
cd addon
terragrunt destroy
```
##### *SHARED*
```shell
cd shared
#KMS
cd kms
terragrunt destroy
#ECR
cd ecr
terragrunt destroy
```

##### *VPC/COMMON*
```shell
cd vpc
terraform destroy
```
