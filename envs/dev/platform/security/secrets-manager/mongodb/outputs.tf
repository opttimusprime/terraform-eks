output "mongodb_secret_name" {
  value = aws_secretsmanager_secret.mongodb.name
}

output "mongodb_secret_arn" {
  value = aws_secretsmanager_secret.mongodb.arn
}