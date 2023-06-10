### This repo bootstraps AWS cloud with EKS cluster

#### Supported types of Cluster
- [x] EKS Managed
- [ ] EKS Fargate

### What it does
- [x] creates vpc 
- [x] creates bastion host
- [x] creates eks cluster and supporting roles and infra
- [x] creates databases <!--- optional --->

### infra setup order
```shell 
git clone https://github.com/bishalkc/terraform-eks.git
```
**VPC**
```shell 
cd common
```
```shell 
terraform init
``` 
```shell 
terraform apply
```

**CLUSTER**
```shell 
cd cluster
```
```shell 
terraform init
``` 
```shell 
terraform apply
```

**DATABASE** <!--- If needed --->
```shell 
cd database
```
```shell 
terraform init
``` 
```shell 
terraform apply
```


### Clean up
**DATABASE** <!--- If provisioned --->
```shell 
cd database
```
```shell 
terraform destroy
```
**CLUSTER**
```shell 
cd cluster
```
```shell 
terraform destroy
```
**VPC/COMMON**
```shell 
cd database
```
```shell 
terraform destroy
```