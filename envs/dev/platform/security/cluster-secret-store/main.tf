resource "kubernetes_manifest" "cluster_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"

    metadata = {
      name = local.cluster_secret_store_name
    }

    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = var.aws_region

          auth = {
            jwt = {
              serviceAccountRef = {
                name      = local.eso_service_account
                namespace = local.eso_namespace
              }
            }
          }
        }
      }
    }
  }
}
