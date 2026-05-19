output "mongodb_release_name" {
  value = helm_release.mongodb.name
}

output "mongodb_namespace" {
  value = helm_release.mongodb.namespace
}