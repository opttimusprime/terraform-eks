resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.cert_manager_namespace

    labels = {
      "app.kubernetes.io/name"       = "cert-manager"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.cert_manager_chart_version

  set {
    name  = "installCRDs"
    value = "true"
  }

  wait    = true
  timeout = 600
}

resource "kubernetes_manifest" "letsencrypt_dev" {
  depends_on = [helm_release.cert_manager]

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

# ------------------------------------------------------------
# QA ClusterIssuer - Uncomment when qa.optimusprime.uno is needed
# ------------------------------------------------------------
# resource "kubernetes_manifest" "letsencrypt_qa" {
#   depends_on = [helm_release.cert_manager]
#
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#
#     metadata = {
#       name = "letsencrypt-qa"
#     }
#
#     spec = {
#       acme = {
#         email  = var.letsencrypt_email
#         server = "https://acme-v02.api.letsencrypt.org/directory"
#
#         privateKeySecretRef = {
#           name = "letsencrypt-qa-account-key"
#         }
#
#         solvers = [
#           {
#             http01 = {
#               ingress = {
#                 class = "alb"
#               }
#             }
#           }
#         ]
#       }
#     }
#   }
# }

# ------------------------------------------------------------
# Preprod ClusterIssuer - Uncomment when preprod.optimusprime.uno is needed
# ------------------------------------------------------------
# resource "kubernetes_manifest" "letsencrypt_preprod" {
#   depends_on = [helm_release.cert_manager]
#
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#
#     metadata = {
#       name = "letsencrypt-preprod"
#     }
#
#     spec = {
#       acme = {
#         email  = var.letsencrypt_email
#         server = "https://acme-v02.api.letsencrypt.org/directory"
#
#         privateKeySecretRef = {
#           name = "letsencrypt-preprod-account-key"
#         }
#
#         solvers = [
#           {
#             http01 = {
#               ingress = {
#                 class = "alb"
#               }
#             }
#           }
#         ]
#       }
#     }
#   }
# }

# ------------------------------------------------------------
# Prod ClusterIssuer - Uncomment when optimusprime.uno is needed
# ------------------------------------------------------------
# resource "kubernetes_manifest" "letsencrypt_prod" {
#   depends_on = [helm_release.cert_manager]
#
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "ClusterIssuer"
#
#     metadata = {
#       name = "letsencrypt-prod"
#     }
#
#     spec = {
#       acme = {
#         email  = var.letsencrypt_email
#         server = "https://acme-v02.api.letsencrypt.org/directory"
#
#         privateKeySecretRef = {
#           name = "letsencrypt-prod-account-key"
#         }
#
#         solvers = [
#           {
#             http01 = {
#               ingress = {
#                 class = "alb"
#               }
#             }
#           }
#         ]
#       }
#     }
#   }
# }