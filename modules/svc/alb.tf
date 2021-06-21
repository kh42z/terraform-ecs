resource "aws_lb" "alb" {
  name               = "${var.env_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sgs_id
  subnets            = var.subnets_id

  enable_deletion_protection = false

}

resource "aws_lb_target_group" "alb-tg" {
  name     = "${var.env_prefix}-alb-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  depends_on = [aws_lb.alb]
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 8000
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    type = "forward"
  }
  depends_on = [aws_lb_target_group.alb-tg]
}
