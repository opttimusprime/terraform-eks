#############################################
# IAM Role for K8s Workstation
#############################################

resource "aws_iam_role" "k8s_workstation_role" {
  name = "${var.project}-${var.environment}-k8s-workstation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "k8s_workstation_admin" {
  role       = aws_iam_role.k8s_workstation_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "k8s_workstation_profile" {
  name = "${var.project}-${var.environment}-k8s-workstation-profile"
  role = aws_iam_role.k8s_workstation_role.name
}

#############################################
# Security Group
#############################################

resource "aws_security_group" "k8s_workstation_sg" {
  name        = "${var.project}-${var.environment}-k8s-workstation-sg"
  description = "Security group for k8s workstation"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "SSH from my laptop"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project}-${var.environment}-k8s-workstation-sg"
  })
}


#############################################
# EC2 K8s Workstation
#############################################

resource "aws_instance" "k8s_workstation" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.workstation_instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.k8s_workstation_sg.id]
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.k8s_workstation_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  user_data = <<-EOF
#!/bin/bash
set -e

dnf update -y
dnf install -y git unzip wget tar yum-utils docker

systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
cd /tmp
unzip awscliv2.zip
./aws/install

# Terraform
dnf install -y dnf-plugins-core
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
dnf install -y terraform

# kubectl
curl -LO "https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl

# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# eksctl
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin

# Final verification
git --version
terraform version
aws --version
kubectl version --client
helm version
eksctl version
docker --version
EOF

  tags = merge(local.common_tags, {
    Name = "${var.project}-${var.environment}-k8s-workstation"
  })
}