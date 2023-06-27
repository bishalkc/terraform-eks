################################################################################
# CERTMANAGER HELM
################################################################################
resource "kubernetes_namespace" "cert_manager_namespace" {
  count = var.enable_lb_controller ? 1 : 0

  metadata {
    annotations = {
      name = "cert-manager"
    }
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  count = var.enable_lb_controller ? 1 : 0

  name       = "cert-manager"
  namespace  = "cert-manager"
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"

  set {
    name  = "installCRDs"
    value = "true"
  }
  depends_on = [kubernetes_namespace.cert_manager_namespace]
}
