# resource "aws_ecs_cluster" "cluster" {
#   name = var.container_name

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# resource "aws_ecs_task_definition" "define" {
#   family = "service"
#   container_definitions = jsonencode([
#     {
#       name      = "django"
#       image     = var.image_url
#       requires_compatibilities = ["FARGATE"]
#       network_mode = "awsvpc"
#       cpu       = 512
#       memory    = 1024
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8000
#           hostPort      = 8000
#         }
#         ]
#     }
#   ])
# }

# resource "aws_ecs_service" "service" {
#   name            = var.service_name
#   cluster         = aws_ecs_cluster.cluster.id
#   task_definition = aws_ecs_task_definition.define.arn
#   desired_count   = 2
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets         = var.subnets.id
#     security_groups = ver.sg_id
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.django.arn
#     container_name   = "django"   
#     container_port   = 8000      
#   }
# }