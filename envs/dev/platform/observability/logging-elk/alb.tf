resource "aws_lb" "kibana" {
  name               = "${var.project}-${var.environment}-kibana"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kibana_alb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnets

  tags = local.common_tags
}

resource "aws_lb_target_group" "kibana" {
  name     = "${var.project}-${var.environment}-kibana"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/api/status"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = local.common_tags
}

resource "aws_lb_target_group_attachment" "kibana" {
  target_group_arn = aws_lb_target_group.kibana.arn
  target_id        = aws_instance.elk.id
  port             = 5601
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.kibana.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.kibana.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kibana.arn
  }
}