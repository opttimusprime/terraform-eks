resource "kubernetes_namespace" "catalogue" {
  metadata {
    name = "catalogue"
  }
}

resource "kubernetes_namespace" "frontend" {
  metadata {
    name = "frontend"
  }
}

resource "kubernetes_namespace" "mongodb" {
  metadata {
    name = "mongodb"
  }
}