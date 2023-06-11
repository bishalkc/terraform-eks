# Bootstrap

You will need to make for changes according to your liking. 
1. Make appropriate changes according to your setup in `init.tf`
2. Change `vars.tf` appropriately
2. Change `local.tf` to reflect your values

## Terraform 

```shell 
terraform init
terraform apply
```

# Common Resources

AWS resources, especially networking resources such as VPC and it's components are shared resources to be utilized within the Sandbox Account.

## VPC

AWS Account has VPC in the us-east-1 (N. Virgina) region with a VPC CIDR Block of `10.100.0.0/16`. An Internet Gateway has been attached to the VPC.

## NAT Gateways

There are two NAT Gateways. Each one placed in a different availability zone (us-east-1a & us-east-1b) to provide High Availability in case that one of the availability zone in the us-east-1 region goes down.

Both NAT Gateways have EIP's allocated to them and have been placed in the Public Subnets with CIDR's `10.100.0.0/26`, `10.100.0.64/26` && `10.100.0.128/26`

## Route Tables:

There is 1 Public Route Table and 2 Private Route tables.

- Public Route Table has a local route for VPC traffic and a route that targets Internet Gateway for non-vpc/public traffic.
- Private Route Table 1 has a local route for VPC traffic and a route that targets NAT Gateway in us-east-1a for non-vpc/public traffic.


## Subnets

Following table consists a list of current subnets.

Type     | CIDR            | Range (Network)               | Range (AWS Usable)          | Addresses | Availability Zone | Notes
-------- | --------------- | ----------------------------- | --------------------------- | --------- | ----------------- | --------------------------------------------
Public   | 10.100.0.0/26   | 10.100.0.0 - 10.100.0.63    | 10.100.0.0 - 10.100.0.59      | 64        | us-east-1a        | Public subnet for ALB, Bastion etc..
Public   | 10.100.0.64/26  | 10.100.0.64 - 10.100.0.127  | 10.100.0.64 - 10.100.0.119    | 64        | us-east-1b        | Public subnet for ALB, Bastion etc..
Public   | 10.100.0.128/26 | 10.100.0.128 - 10.100.0.187 | 10.100.0.128 - 10.100.0.187   | 64        | us-east-1c        | Public subnet for ALB, Bastion etc..
Database | 10.100.1.0/27   | 10.100.1.0 - 10.100.1.31    | 10.100.1.0 - 10.100.1.26      | 32        | us-east-1a        | Private subnet for Database(s)
Database | 10.100.1.32/27  | 10.100.1.32 - 10.100.1.63   | 10.100.1.32 - 10.100.1.59     | 32        | us-east-1b        | Private subnet for Database(s)
Database | 10.100.1.64/27  | 10.100.1.64 - 10.100.1.127  | 10.100.1.64 - 10.100.1.191    | 32        | us-east-1c        | Private subnet for Database(s)
Svcs     | 10.100.3.0/27   | 10.100.3.0 - 10.100.3.31    | 10.100.3.0 - 10.100.3.26      | 32        | us-east-1a        | Private subnet for Appliances/Services Usage
Svcs     | 10.100.3.32/27  | 10.100.3.32 - 10.100.3.63   | 10.100.3.32 - 10.100.3.59     | 32        | us-east-1b        | Private subnet for Appliances/Services Usage
Svcs     | 10.100.3.64/27  | 10.100.3.64 - 10.100.3.127  | 10.100.3.64 - 10.100.3.191    | 32        | us-east-1c        | Private subnet for Appliances/Services Usage
cp       | 10.100.2.0/28   | 10.100.2.0 - 10.100.2.15    | 10.100.2.0 - 10.100.2.11      | 16        | us-east-1a        | Private subnet for EKS Cluster Control Plane
cp       | 10.100.2.16/28  | 10.100.2.16 - 10.100.2.31   | 10.100.2.16 - 10.100.2.27     | 16        | us-east-1b        | Private subnet for EKS Cluster Control Plane
cp       | 10.100.2.32/28  | 10.100.2.32 - 10.100.2.63   | 10.100.2.32 - 10.100.2.43     | 16        | us-east-1c        | Private subnet for EKS Cluster Control Plane
worker   | 10.100.16.0/20  | 10.100.16.0 - 10.100.31.255 | 10.100.16.132 - 10.100.31.250 | 4096      | us-east-1a        | Private subnet for EKS Cluster Workers
worker   | 10.100.32.0/20  | 10.100.32.0 - 10.100.47.255 | 10.100.32.132 - 10.100.47.250 | 4096      | us-east-1b        | Private subnet for EKS Cluster Workers
worker   | 10.100.48.0/20  | 10.100.48.0 - 10.100.63.255 | 10.100.48.132 - 10.100.63.250 | 4096      | us-east-1c        | Private subnet for EKS Cluster Workers

**Subnets Summary**

- Public subnets can be utilized for anything we need public facing for now
- Private subnets for EKS Cluster Control Plane is only for the ENI's that AWS provisions for EKS Control Plane.
- Private subnets for Database are to be utilized for RDS 
- Private subnets for Appliances/Services related EC2 instances (or other components).
- Private subnets for EKS worker nodes is only to provision the worker nodes in appropriate subnets.
- Further use of the network ranges within the VPC will be decided later as per need basis.
