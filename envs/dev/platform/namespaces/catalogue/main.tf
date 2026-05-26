resource "kubernetes_namespace" "catalogue" {

  metadata {
    name = "catalogue"

    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }
}