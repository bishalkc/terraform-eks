# Bootstrap

You will need to make for changes according to your liking. 
1. Make appropriate changes according to your setup in `init.tf`
2. Change `local.tf` to reflect your values

## Terraform 

1. run ```terraform init```
2. run ```terraform apply```

### Post install config

Make sure your cluster is up and running

- configure your local environment to connect to cluster
  run ```aws eks update-kubeconfig --name {clustername}```
- make sure all system are optimal 
  run ```kubectl get nodes```
  run ```kubect get po -A```

### POSTINSTALL NOTES:

#### aws-auth refer [here](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html) for more details
For example look at `files/aws-auth-cm.yaml`

#### LB Controller
For setting up service account and installing aws-load-balancer-controller using helm:

Please make sure you have appropriate role and account number specified in `files/aws-load-balancer-controller-service-account.yaml`

run ```kubectl apply -f files/aws-load-balancer-controller-service-account.yaml```

run ```helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=tetra-tech-dev-eks --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller```