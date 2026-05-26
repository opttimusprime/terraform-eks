resource "helm_release" "mongodb" {
  name      = "mongodb"
  namespace = data.terraform_remote_state.namespace.outputs.namespace

  create_namespace = false

  chart = "${path.module}/../helm"

  values = [
    file("${path.module}/../helm/values.yaml"),
    
  ]
  timeout = 1200
  wait    = true

  depends_on = [
    data.terraform_remote_state.namespace,
    data.terraform_remote_state.storageclass
  ]
}
