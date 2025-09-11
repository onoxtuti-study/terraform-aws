resource "aws_ecs_cluster" "cluster" {
  name = var.container_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "define" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.execution_iam_arn
  task_role_arn = var.task_iam_arn

  container_definitions = jsonencode([
    {
      name      = "django"
      image     = var.django_image_url
      essential = true
      portMappings = [
        {
          containerPort = 8000
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/django"
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    },
    {
      name = "nginx"
      image = var.nginx_image_url
      essential = true
      portMappings = [
        {
          containerPort = 80
        }
      ]
      dependsOn = [
      {
        containerName = "django"
        condition     = "START"
      }
    ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "/ecs/django"
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.define.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets         = var.subnets_id
    security_groups = var.sg_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.trg_arn
    container_name   = "nginx"   
    container_port   = 80     
  }
}