### This repo bootstraps AWS cloud with EKS cluster

#### Supported types of Cluster
- [x] EKS Managed
- [ ] EKS Fargate

### What it does
- [x] creates vpc 
- [x] creates bastion host
- [x] creates eks cluster and supporting roles and infra
- [x] creates databases <!--- optional --->

### *Infra setup in order*
```shell 
git clone https://github.com/bishalkc/terraform-eks.git
cd terraform-eks
```
##### *VPC/COMMON*
```shell 
cd common
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


### *CLEAN UP*
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
cd database
terraform destroy
```