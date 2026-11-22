output "k8s_workstation_role_arn" {
  value = aws_iam_role.k8s_workstation_role.arn
}

output "k8s_workstation_security_group_id" {
  value = aws_security_group.k8s_workstation_sg.id
}

output "k8s_workstation_public_ip" {
  value = aws_instance.k8s_workstation.public_ip
}

output "k8s_workstation_instance_id" {
  value = aws_instance.k8s_workstation.id
}