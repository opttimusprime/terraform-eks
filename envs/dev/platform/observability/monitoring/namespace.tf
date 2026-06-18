resource "kubernetes_namespace" "monitoring" {
  metadata {
    name   = "monitoring"
    labels = local.common_tags
  }
}