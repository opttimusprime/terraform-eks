output "catalogue_secret_name" {
  value = aws_secretsmanager_secret.catalogue.name
}

output "catalogue_secret_arn" {
  value = aws_secretsmanager_secret.catalogue.arn
}