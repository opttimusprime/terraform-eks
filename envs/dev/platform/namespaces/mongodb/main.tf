resource "kubernetes_namespace" "mongodb" {

  metadata {
    name = "mongodb"

    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }
}