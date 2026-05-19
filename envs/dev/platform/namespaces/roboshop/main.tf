resource "kubernetes_namespace" "roboshop" {

  metadata {
    name = "roboshop"

    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }
}