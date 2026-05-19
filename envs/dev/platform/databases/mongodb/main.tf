resource "helm_release" "mongodb" {

  name       = "mongodb"
  namespace  = "roboshop"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = "15.6.18"

  create_namespace = true

  values = [
    file("${path.module}/helm/values.yaml")
  ]
}