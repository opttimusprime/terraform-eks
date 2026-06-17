resource "helm_release" "external_dns" {
  name       = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name

  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = var.external_dns_chart_version

  create_namespace = false

  values = [
    yamlencode({
      provider = {
        name = "aws"
      }

      policy   = "sync"
      registry = "txt"

      txtOwnerId = data.aws_eks_cluster.this.name

      domainFilters = [
        var.domain_name
      ]

      serviceAccount = {
        create = false
        name   = kubernetes_service_account.external_dns.metadata[0].name
      }
    })
  ]

  wait    = true
  timeout = 600

  depends_on = [
    kubernetes_service_account.external_dns
  ]
}