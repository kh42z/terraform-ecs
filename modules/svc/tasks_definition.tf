resource "aws_ecs_task_definition" "task" {
  family = "${var.env_prefix}-task"
  container_definitions = jsonencode([
    {
      name      = var.env_prefix
      image     = var.image
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
            awslogs-group = aws_cloudwatch_log_group.cw.name
            awslogs-region = var.region
            awslogs-stream-prefix = var.env_prefix
        }
    },
      environment = [
            { name = "REQUIREMENTS_PATH", value = "/requirements.txt"}
        ],
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ],
      memory = var.app_memory
      cpu    = var.app_cpu

    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.app_memory
  cpu                      = var.app_cpu
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}