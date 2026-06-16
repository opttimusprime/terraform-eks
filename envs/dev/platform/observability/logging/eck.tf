resource "helm_release" "eck_operator" {
  name       = "eck-operator"
  namespace  = kubernetes_namespace.elastic_system.metadata[0].name

  repository = "https://helm.elastic.co"
  chart      = "eck-operator"

  wait    = true
  timeout = 600

  depends_on = [
    kubernetes_namespace.elastic_system
  ]
}