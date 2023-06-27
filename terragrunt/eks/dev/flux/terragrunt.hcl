// #------------------------------------------------------
// # TERRAFORM STATE
// #------------------------------------------------------
// terraform {
//   source = "${get_path_to_repo_root()}//modules/flux-helm"
// }

// include "root" {
//   path = find_in_parent_folders()
// }

// include "env" {
//   path   = find_in_parent_folders("env.hcl")
//   expose = true
// }

// inputs = {
//   flux_path = include.env.locals.git.path
//   git_url   = include.env.locals.git.url
//   git_user  = include.env.locals.git.user
//   git_token = include.env.locals.git.token
// }

// // dependency "eks" {
// //   config_path = "../eks"

// //   mock_outputs = {
// //     oidc_url                   = "https://oidc.eks-us-east-1.amazonaws.com/id/169841B48D5B8A662A4C7AOE2B101423"
// //     oidc_arn                   = "arn:aws:eks-us-east-1:${get_aws_account_id()}:cluster/oidc-demo"
// //     eks_cluster_name           = "demo-cluster-name"
// //     eks_cluster_ca_certificate = "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQoKaXpmck5UbVFMbmZzTHppMldiOXhQejJRajlmUVlHZ2V1ZzNOMk1rRHVWSHdwUGNna2hIa0pnQ1F1dXZUK3FaSQoKTWJTMlU2d1RTMjRTWms1UnVuSklVa2l0UktlV1dNUzI4U0xHZmtEczFiQllsU1BhNXNtQWQzL3ExT2VQaTRhZQoKZFU2WWdXdUR4ekJBS0VLVlNVdTZwQTJIT2R5UTlONEYxZEkrRjh3OUo5OTB6RTkzRWd5TnFaRkJCYTJMNzBoNAoKTTdEckIwZ0pCV01kVU1veEdudW41Z2xMaUNNbzJKckhaOVJrTWlhbGxTMXNITWhFTHgyVUFsUDhJMSswTWF2OAoKaU1sSEd5VVc4RUp5MHBhVmYwOU1QcGNlRWNWd0RCZVgwK0c0VVFsTzU1MUdURnRPU1JqY0Q4VStHa0N6a2E5VwoKL1NGUXJTR2UzR2gzU0RhT3cvNEpFTUFqV1BETGlDZ2x3aDByTElPNFZ3VTZBeHpUQ3VDdzNkMVp4UXNVNlZGUQoKUHFIQThoYU9VQVRaSXJwMzg4NlBCVGhWcUFMQms5cDFOcW41MWJYTGgxM1p5OURaSVZ4NFo1SW96L0VHdXpnUgoKZDY4Vlc1d3liTGpZRTJyNlE5bkhwaXRTWjRaZGVyd2pJWlJlczY3SGR4WUZ3OHVubTRXbzZrdUduYjVqU1NhZwoKdndCeEt6QWYzT21uK0o2SXRoVEpLdURkMTNyS1pHTWNScFFRNlZzdHdpaFl0MVRhaFEvcWZKVVdQalBjVTVNTAoKOUxrZ1Z3QThOZGkxd3AxL3NFUGUrVWxMMTZMNnZPOWpVSGN1ZVdONyt6U1VPRS9jRFNKeU1kOXgvWkw4UUFTQQoKRVRkNWR1alZJcWxJTkwydkpLcjFvNFQraTBSc25wZkZpcUZtQktsRnF3dy9TS3pKZUNoZHlFdHBhL2RKTXJ0MgoKOFM4NmI2ekVta3NlcitTRFlnR2tldFMyRFo0aEIrdmgydWpTWG1TOEdrd3JuK0JmSE16a2J0aW84bFdiR3cwbAoKZU0xdGZkRlo2d01UTGt4UmhCa0JLNEppTWlVTXZwRVJ5UGliNmEyTDZpWFRmSCszUlVEUzZBPT0KCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCgotLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS0KCk1JSUNNekNDQVp5Z0F3SUJBZ0lKQUxpUG5Wc3ZxOGRzTUEwR0NTcUdTSWIzRFFFQkJRVUFNRk14Q3pBSkJnTlYKCkJBWVRBbFZUTVF3d0NnWURWUVFJRXdObWIyOHhEREFLQmdOVkJBY1RBMlp2YnpFTU1Bb0dBMVVFQ2hNRFptOXYKCk1Rd3dDZ1lEVlFRTEV3Tm1iMjh4RERBS0JnTlZCQU1UQTJadmJ6QWVGdzB4TXpBek1Ua3hOVFF3TVRsYUZ3MHgKCk9EQXpNVGd4TlRRd01UbGFNRk14Q3pBSkJnTlZCQVlUQWxWVE1Rd3dDZ1lEVlFRSUV3Tm1iMjh4RERBS0JnTlYKCkJBY1RBMlp2YnpFTU1Bb0dBMVVFQ2hNRFptOXZNUXd3Q2dZRFZRUUxFd05tYjI4eEREQUtCZ05WQkFNVEEyWnYKCmJ6Q0JuekFOQmdrcWhraUc5dzBCQVFFRkFBT0JqUUF3Z1lrQ2dZRUF6ZEdmeGk5Q05iTWYxVVVjdkRRaDdNWUIKCk92ZUlIeWMwRTBLSWJoaks1RmtDQlU0Q2lacmJmSGFnYVc3WkVjTjB0dDNFdnBiT014eGMvWlFVMldOL3Mvd1AKCnhwaDBwU2ZzZkZzVEtNNFJoVFdEMnY0ZmdrK3haaUtkMXAwK0w0aFR0cHduRXcwdVhSVmQwa2k2bXV3VjV5L1AKCis1RkhVZWxkcStwZ1RjZ3p1SzhDQXdFQUFhTVBNQTB3Q3dZRFZSMFBCQVFEQWdMa01BMEdDU3FHU0liM0RRRUIKCkJRVUFBNEdCQUppREFBdFkwbVFRZXV4V2R6TFJ6WG1qdmRTdUw5R295VDNCRi9qU25weHo1LzU4ZGJhOHBXZW4KCnYzcGo0UDN3NURvT3NvMHJ6a1p5MmpFc0VpdGxWTTJtTFNiUXBNTStNVVZRQ1FvaUc2Vzl4dUNGdXhTcndQSVMKCnBBcUVBdVY0RE5veFFLS1dtaFZ2K0owcHRNV0QyNVBucHhlcTVzWHpnaGZKbnNsSmxRTkQKCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0="
// //     eks_cluster_endpoint       = "https://IWYWWBMWPEGVMHTOVKIODPVLIGTAEXSO.gr7.us-east-1.eks.amazonaws.com"
// //   }
// // }
