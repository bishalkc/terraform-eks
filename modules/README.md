### Modules used on all

#### :point_down: Supported types of Modules
- [x] addon
- [x] bastion host
- [x] database
- [x] ecr
- [x] eks
- [x] kms
- [x] lbcontroller
- [x] secret manager
- [x] ssm
- [x] vpc

### What it does
- [x] supports vpc creation
- [x] supports bastion host creation
- [x] supports eks cluster and supporting roles and infra creation
- [x] supports kms, ecr creation
- [x] supports databases creation <!--- optional --->

#### *THE REPO CONSIST OF 3 WAYS OF BUILDING EKS INFRASTRUCTURE AND RESOURCES USING TERRAFORM*

- Traditional terraform with individual `tf files`. [more here](./tf/README.md)
- Modular [more here](./modular/README.md)
- Terragrunt [more here](./terragrunt/README.md)
