
resource "aws_ecs_service" "standalone-svc" {
  name            = "${var.env_prefix}-svc"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task.id
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnets_id
    security_groups  = var.sgs_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    container_name   = var.env_prefix
    container_port   = 8000
  }
  depends_on = [aws_alb_listener.alb-listener]
}