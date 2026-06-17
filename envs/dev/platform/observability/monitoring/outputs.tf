output "monitoring_namespace" {
  value = kubernetes_namespace.monitoring.metadata[0].name
}

output "helm_release_name" {
  value = helm_release.monitoring.name
}

output "helm_release_status" {
  value = helm_release.monitoring.status
}

output "grafana_url" {
  value = "https://grafana.${var.domain_name}"
}

output "prometheus_url" {
  value = "https://prometheus.${var.domain_name}"
}