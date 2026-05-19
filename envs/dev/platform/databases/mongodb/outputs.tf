output "ebs_csi_role_arn" {
  value = module.ebs_csi_irsa_role.iam_role_arn
}

output "storage_class_name" {
  value = kubernetes_storage_class.gp3.metadata[0].name
}