output "cert_manager_namespace" {
  value = kubernetes_namespace.cert_manager.metadata[0].name
}

output "dev_cluster_issuer_name" {
  value = kubernetes_manifest.letsencrypt_dev.manifest.metadata.name
}