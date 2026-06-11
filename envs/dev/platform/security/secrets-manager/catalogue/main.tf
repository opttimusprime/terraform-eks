resource "aws_secretsmanager_secret" "catalogue" {
  name = "${var.project}/${var.environment}/catalogue"

  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "catalogue" {
  secret_id = aws_secretsmanager_secret.catalogue.id

  secret_string = jsonencode({
    MONGO_URL = var.mongo_url
  })
}