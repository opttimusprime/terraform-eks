output "namespace" {
  value = kubernetes_namespace.catalogue.metadata[0].name
}