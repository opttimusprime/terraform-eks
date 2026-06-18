resource "aws_secretsmanager_secret" "catalogue" {
  name        = "${var.project}/${var.environment}/catalogue"
  description = "Catalogue service secrets"

  tags = merge(local.common_tags, {
    Component = "catalogue"
  })
}

resource "aws_secretsmanager_secret_version" "catalogue" {
  secret_id = aws_secretsmanager_secret.catalogue.id

  secret_string = jsonencode({
    MONGO_URL = var.mongo_url
  })
}