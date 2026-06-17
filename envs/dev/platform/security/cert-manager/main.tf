resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.cert_manager_namespace

    labels = {
      "app.kubernetes.io/name"       = "cert-manager"
      "app.kubernetes.io/managed-by" = "terraform"
      "project"                      = var.project
      "environment"                  = var.environment
    }
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_chart_version

  create_namespace = false

  set {
    name  = "crds.enabled"
    value = "true"
  }

  wait    = true
  timeout = 600

  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}

resource "kubernetes_manifest" "letsencrypt_dev" {
  depends_on = [
    helm_release.cert_manager
  ]

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"

    metadata = {
      name = "letsencrypt-dev"
    }

    spec = {
      acme = {
        email  = var.letsencrypt_email
        server = "https://acme-v02.api.letsencrypt.org/directory"

        privateKeySecretRef = {
          name = "letsencrypt-dev-account-key"
        }

        solvers = [
          {
            http01 = {
              ingress = {
                class = "alb"
              }
            }
          }
        ]
      }
    }
  }
}