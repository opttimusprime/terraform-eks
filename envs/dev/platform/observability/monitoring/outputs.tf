output "monitoring_namespace" {
  description = "Monitoring namespace"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}

output "helm_release_name" {
  description = "Helm release name"
  value       = helm_release.monitoring.name
}

output "helm_release_status" {
  description = "Helm release status"
  value       = helm_release.monitoring.status
}