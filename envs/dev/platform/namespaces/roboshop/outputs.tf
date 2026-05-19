output "namespace" {
  value = kubernetes_namespace.roboshop.metadata[0].name
}