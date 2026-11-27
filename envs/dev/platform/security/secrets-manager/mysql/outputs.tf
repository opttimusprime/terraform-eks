output "mysql_secret_name" {
  value = aws_secretsmanager_secret.mysql.name
}

output "mysql_secret_arn" {
  value = aws_secretsmanager_secret.mysql.arn
}