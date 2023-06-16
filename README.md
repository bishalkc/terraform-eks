### This repo bootstraps AWS cloud with EKS cluster

#### Supported types of Cluster
- [x] EKS Managed
- [x] EKS Fargate

### What it does
- [x] creates vpc
- [x] creates bastion host
- [x] creates eks cluster and supporting roles and infra
- [x] creates databases <!--- optional --->

#### :point_down: *THE REPO CONSIST OF 3 WAYS OF BUILDING EKS INFRASTRUCTURE AND RESOURCES USING TERRAFORM*

- Traditional terraform with individual `tf files`. [more here](./tf/README.md)
- Modular [more here](./modular/README.md)
- Terragrunt [more here](./terragrunt/README.md)
