###################### Create clusters ##########################
resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.stage_name}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

###################### Create task definitions ##########################
resource "aws_ecs_task_definition" "this" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role.task_exec_role.arn
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "${var.repository_url}:latest"
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_fargate_task_lg_name
          awslogs-stream-prefix = "ecs"
          awslogs-region        = var.aws_region
        }
      }
      health_check = {
        command : ["CMD-SHELL", "curl -f http://localhost/8501 || exit 1"]
        internal : 30
        timeout : 5
        retries : 3
        startPeriod : 60
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = var.tags
}

###################### Create Elastic Container Service ##########################
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-${var.stage_name}-ecs"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn

  # Environment
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  # Deployment configuration
  force_new_deployment = true
  scheduling_strategy  = "REPLICA"
  desired_count        = 2
  # deployment_controller {
  #   type = "CODE_DEPLOY"
  # }

  network_configuration {
    subnets         = [var.private_subnet_1_id, var.private_subnet_2_id]
    security_groups = [var.sg_ecs_tasks_id]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  tags = var.tags
}