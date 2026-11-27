resource "aws_secretsmanager_secret" "mysql" {
  name        = "${var.project}/${var.environment}/mysql"
  description = "MySQL secrets"

  tags = merge(local.common_tags, {
    Component = "mysql"
  })
}

resource "aws_secretsmanager_secret_version" "mysql" {
  secret_id = aws_secretsmanager_secret.mysql.id

  secret_string = jsonencode({
    MYSQL_ROOT_PASSWORD = var.mysql_root_password
  })
}