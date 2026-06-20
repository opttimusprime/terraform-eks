resource "aws_instance" "elk" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.elk.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/user-data/elk.sh", {
    kibana_url = "https://kibana.${var.domain_name}"
  })

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "${local.name}-ec2"
  })
}