output "cert_manager_namespace" {
  value = kubernetes_namespace.cert_manager.metadata[0].name
}

output "cert_manager_helm_release_name" {
  value = helm_release.cert_manager.name
}

output "cert_manager_helm_release_status" {
  value = helm_release.cert_manager.status
}

output "dev_cluster_issuer_name" {
  value = kubernetes_manifest.letsencrypt_dev.manifest.metadata.name
}