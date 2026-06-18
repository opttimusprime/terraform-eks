resource "aws_secretsmanager_secret" "mongodb" {
  name        = "${var.project}/${var.environment}/mongodb"
  description = "MongoDB secrets"

  tags = merge(local.common_tags, {
    Component = "mongodb"
  })
}

resource "aws_secretsmanager_secret_version" "mongodb" {
  secret_id = aws_secretsmanager_secret.mongodb.id

  secret_string = jsonencode({
    MONGO_INITDB_ROOT_USERNAME = var.mongodb_root_username
    MONGO_INITDB_ROOT_PASSWORD = var.mongodb_root_password
    MONGO_REPLICA_SET_KEY      = var.mongodb_replicaset_key
  })
}