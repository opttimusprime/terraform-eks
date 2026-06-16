resource "kubernetes_namespace" "elastic_system" {
  metadata {
    name = "elastic-system"

    labels = local.common_tags
  }
}

resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"

    labels = local.common_tags
  }
}