# Locals for common
data "tls_certificate" "oidc" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  my_ip = chomp(data.http.myip.response_body)
}
