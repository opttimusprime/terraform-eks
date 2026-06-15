resource "helm_release" "monitoring" {
  name       = "monitoring"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = false

  wait    = true
  timeout = 600

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}