output "namespace" {
  value = kubernetes_namespace.mongodb.metadata[0].name
}