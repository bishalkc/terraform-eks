### This repo bootstraps AWS cloud with EKS cluster

- creates vpc 
- creates bastion host
- creates eks cluster and supporting roles and infra
- creates databases (if needed )

### infra setup order
- run `terraform init` and `terraform apply` on common folder
- run `terraform init` and `terraform apply` on eks folder
- run `terraform` on database folder // IF neeeded

### Clean up 
- run ```terraform destroy``` on database folder // if provisioned
- run ```terraform destroy``` on eks folder
- run ```terraform destroy``` on common folder