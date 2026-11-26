resource "aws_secretsmanager_secret" "user" {
  name        = "${var.project}/${var.environment}/user"
  description = "User service secrets"

  tags = merge(local.common_tags, {
    Component = "user"
  })
}

resource "aws_secretsmanager_secret_version" "user" {
  secret_id = aws_secretsmanager_secret.user.id

  secret_string = jsonencode({
    MONGO_URL = var.mongo_url
  })
}