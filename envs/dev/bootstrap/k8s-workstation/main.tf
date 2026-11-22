
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

#############################################
# Attach AdministratorAccess Policy
#############################################

resource "aws_iam_role_policy_attachment" "k8s_workstation_admin" {
  role       = aws_iam_role.k8s_workstation_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#############################################
# IAM Instance Profile
#############################################

resource "aws_iam_instance_profile" "k8s_workstation_profile" {
  name = "${var.project}-${var.environment}-k8s-workstation-profile"
  role = aws_iam_role.k8s_workstation_role.name

  tags = local.common_tags
}

#############################################
# Security Group
#############################################

resource "aws_security_group" "k8s_workstation_sg" {
  name        = "${var.project}-${var.environment}-k8s-workstation-sg"
  description = "Security group for K8s workstation"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "SSH from my laptop"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.vpc.outputs.my_public_ip
    ]

  }

  egress {
    description = "Allow outbound traffic"
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

  ###########################################
  # Root EBS Volume
  ###########################################

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  ###########################################
  # User Data - Install DevOps Tools
  ###########################################

  user_data = <<-EOF
#!/bin/bash
set -euxo pipefail

# Log installation output
exec > >(tee /var/log/user-data.log) 2>&1

#############################################
# 1. Update OS and install dependencies
#############################################

dnf update -y
dnf install -y git unzip wget tar curl docker

#############################################
# 2. Configure Docker
#############################################

systemctl enable --now docker
usermod -aG docker ec2-user

#############################################
# 3. Install or update AWS CLI v2
#############################################

cd /tmp

if ! command -v aws >/dev/null 2>&1; then
  curl -fSL --retry 3 \
    "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o awscliv2.zip

  unzip -oq awscliv2.zip
  ./aws/install
else
  aws --version
fi

#############################################
# 4. Install Terraform 1.10.1
#############################################

curl -fSL --retry 3 \
  "https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_amd64.zip" \
  -o terraform.zip

unzip -oq terraform.zip terraform
install -m 0755 terraform /usr/local/bin/terraform

#############################################
# 5. Install kubectl 1.35.0
#############################################

KUBECTL_VERSION="1.35.0"

curl -fSL --retry 3 \
  "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" \
  -o kubectl

install -m 0755 kubectl /usr/local/bin/kubectl

#############################################
# 6. Install Helm 3
#############################################

curl -fSL --retry 3 \
  "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" \
  -o get_helm.sh

chmod 700 get_helm.sh
DESIRED_VERSION="v3.19.0" ./get_helm.sh

#############################################
# 7. Install eksctl
#############################################

curl -fSL --retry 3 \
  "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
  -o eksctl.tar.gz

tar -xzf eksctl.tar.gz -C /tmp eksctl
install -m 0755 /tmp/eksctl /usr/local/bin/eksctl

#############################################
# 8. Verify installed tools
#############################################

echo "========== TOOL VERSIONS =========="

git --version
docker --version
aws --version
terraform version
kubectl version --client
helm version --short
eksctl version

#############################################
# 9. Verify Docker service
#############################################

systemctl is-active docker

echo "==================================="
echo "K8s Workstation setup completed"
echo "==================================="
EOF

  tags = merge(local.common_tags, {
    Name = "${var.project}-${var.environment}-k8s-workstation"
  })
}
