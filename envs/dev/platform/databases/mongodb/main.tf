resource "helm_release" "mongodb" {
  name      = "mongodb"
  namespace = data.terraform_remote_state.namespace.outputs.namespace

  create_namespace = false

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "mongodb"
  version    = "15.6.18"

  values = [
    file("${path.module}/helm/values.yaml"),
    file("${path.module}/helm/secrets.yaml")
  ]

  depends_on = [
    data.terraform_remote_state.namespace,
    data.terraform_remote_state.storageclass
  ]
}