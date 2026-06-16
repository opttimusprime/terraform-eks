output "elastic_namespace" {
  value = kubernetes_namespace.elastic_system.metadata[0].name
}

output "logging_namespace" {
  value = kubernetes_namespace.logging.metadata[0].name
}

output "eck_operator_release" {
  value = helm_release.eck_operator.name
}