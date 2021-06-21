resource "aws_ecs_cluster" "default" {
  name = "${var.env}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}