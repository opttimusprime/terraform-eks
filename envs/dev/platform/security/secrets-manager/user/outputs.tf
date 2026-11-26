output "user_secret_name" {
  value = aws_secretsmanager_secret.user.name
}

output "user_secret_arn" {
  value = aws_secretsmanager_secret.user.arn
}