############ ECR ############
resource "aws_ecr_repository" "ecr" {
  name = "${var.project}-${var.environment}-ecr"
  force_delete = true
}

############ ECS クラスター ############
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster-terraform"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

############ ECS サービス ############
resource "aws_ecs_service" "ecs-service" {
  name            = "ecs-service-front-terraform"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-front-fargate.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["${aws_subnet.public_subnet_1a.id}","${aws_subnet.public_subnet_1c.id}"]
    security_groups  = ["${aws_security_group.front-sg.id}"]
    assign_public_ip = "false"
  }
}

############ ECS タスク定義(フロント) ############
resource "aws_ecs_task_definition" "ecs-front-fargate" {
  family                   = "ecs-task-front-terraform"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "Nginx",
    "image": "nginx",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION
}

# ############ ECS タスク定義(バックエンド) ############
# resource "aws_ecs_task_definition" "ecs-backend-fargate" {
#   family                   = "ecs-task-backend-terraform"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = 1024
#   memory                   = 2048
#   container_definitions    = <<TASK_DEFINITION
# [
#   {
#     "name": "Nginx",
#     "image": "nginx",
#     "cpu": 1024,
#     "memory": 2048,
#     "essential": true
#   }
# ]
# TASK_DEFINITION
# }