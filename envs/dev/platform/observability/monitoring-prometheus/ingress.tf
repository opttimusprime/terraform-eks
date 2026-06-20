resource "kubernetes_ingress_v1" "monitoring" {
  metadata {
    name      = "monitoring-ingress"
    namespace = kubernetes_namespace.monitoring.metadata[0].name

    annotations = {
      "kubernetes.io/ingress.class"               = "alb"
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/listen-ports"    = jsonencode([{ HTTP = 80 }, { HTTPS = 443 }])
      "alb.ingress.kubernetes.io/certificate-arn" = var.acm_certificate_arn
      "alb.ingress.kubernetes.io/ssl-redirect"    = "443"
      "alb.ingress.kubernetes.io/inbound-cidrs"   = var.allowed_ingress_cidr

      "external-dns.alpha.kubernetes.io/hostname" = "grafana.${var.domain_name},prometheus.${var.domain_name}"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = "grafana.${var.domain_name}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "monitoring-grafana"

              port {
                number = 80
              }
            }
          }
        }
      }
    }

    rule {
      host = "prometheus.${var.domain_name}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "monitoring-kube-prometheus-prometheus"

              port {
                number = 9090
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.monitoring
  ]
}