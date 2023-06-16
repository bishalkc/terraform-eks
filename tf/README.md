### This repo bootstraps AWS cloud with EKS cluster

#### Supported types of Cluster
- [x] EKS Managed
- [ ] EKS Fargate

### What it does
- [x] creates vpc
- [x] creates bastion host
- [x] creates eks cluster and supporting roles and infra
- [x] creates databases <!--- optional --->

#### :heavy_exclamation_mark: *BEFORE RUNNING `TERRAFORM` PLEASE UPDATE `{TYPE}/{ENV}/{ROLE}/locals.tf` AS NEEDED* :heavy_exclamation_mark:

### *Infra setup in order*
```shell
git clone https://github.com/bishalkc/terraform-eks.git
cd terraform-eks
pre-commit install // make sure you have pre-commit installed
```
##### *VPC/COMMON*
```shell
cd vpc
terraform init
terraform apply
```

##### *CLUSTER*
```shell
cd cluster
terraform init
terraform apply
```

##### *DATABASE* <!--- If needed --->
```shell
cd database
terraform init
terraform apply
```

##### *APP* <!--- If needed --->
```shell
cd app
terraform init
terraform apply
```

### *CLEAN UP*
##### *APP* <!--- If provisioned --->
```shell
cd app
terraform destroy
```

##### *DATABASE* <!--- If provisioned --->
```shell
cd database
terraform destroy
```
##### *CLUSTER*
```shell
cd cluster
terraform destroy
```

##### *VPC/COMMON*
```shell
cd vpc
terraform destroy
```
