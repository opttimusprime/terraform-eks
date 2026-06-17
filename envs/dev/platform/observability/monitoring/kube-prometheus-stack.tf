resource "helm_release" "monitoring" {
  name       = "monitoring"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = false

  wait    = true
  timeout = 900

  values = [
    yamlencode({
      prometheus = {
        prometheusSpec = {
          retention = "7d"

          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "gp3"
                accessModes      = ["ReadWriteOnce"]

                resources = {
                  requests = {
                    storage = "10Gi"
                  }
                }
              }
            }
          }
        }
      }

      grafana = {
        enabled       = true
        adminPassword = var.grafana_admin_password

        persistence = {
          enabled          = true
          type             = "pvc"
          storageClassName = "gp3"
          accessModes      = ["ReadWriteOnce"]
          size             = "10Gi"
        }

        service = {
          type = "ClusterIP"
        }
      }

      alertmanager = {
        alertmanagerSpec = {
          storage = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "gp3"
                accessModes      = ["ReadWriteOnce"]

                resources = {
                  requests = {
                    storage = "5Gi"
                  }
                }
              }
            }
          }
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
}