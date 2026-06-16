resource "kubernetes_manifest" "elasticsearch" {
  depends_on = [helm_release.eck_operator]

  manifest = {
    apiVersion = "elasticsearch.k8s.elastic.co/v1"
    kind       = "Elasticsearch"

    metadata = {
      name      = "elasticsearch"
      namespace = "logging"
    }

    spec = {
      version = "8.18.0"

      nodeSets = [
        {
          name  = "default"
          count = 1

          config = {
            "node.store.allow_mmap" = false
          }
        }
      ]
    }
  }
}