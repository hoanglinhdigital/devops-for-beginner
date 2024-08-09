resource "aws_ecs_cluster" "udemy_devops_ecs_cluster" {
  name = "udemy-devops-ecs-cluster"
  
}

resource "aws_ecs_task_definition" "nodejs_task_definition" {
  family                   = "nodejs-task-definition"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  // task_role_arn            = aws_iam_role.task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = <<DEFINITION
  [
    {
      "name": "nodejs-container",
      "image": "${var.nodejs_ecr_image_url}",
      "cpu": 512,
      "memory": 1024,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.nodejs_log_group.name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "nodejs-container"
        }
      }
    }
  ]
  DEFINITION
}
resource "aws_cloudwatch_log_group" "nodejs_log_group" {
  name = "ecs/nodejs-log-group"
  retention_in_days = 7
}

resource "aws_iam_role" "task_execution_role" {
  name = "nodejs-task-execution-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "task_execution_policy" {
  name        = "nodejs-task-execution-policy"
  description = "Policy for ECS task execution role"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "task_execution_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_policy.arn
}

resource "aws_ecs_service" "nodejs_service" {
  name            = "nodejs-service"
  network_configuration {
    subnets = var.ecs_subnet_ids
    security_groups = var.ecs_security_group_ids
    assign_public_ip = true
  }
  cluster         = aws_ecs_cluster.udemy_devops_ecs_cluster.id
  task_definition = aws_ecs_task_definition.nodejs_task_definition.arn
  desired_count   = 4
  launch_type     = "FARGATE"
  // iam_role        = aws_iam_role.foo.arn
  //depends_on      = [aws_iam_role_policy.foo]

  load_balancer {
    target_group_arn = var.nodejs_target_group_blue_arn
    container_name   = "nodejs-container"
    container_port   = 3000
  }
  deployment_controller {
    type = "CODE_DEPLOY" // ECS Deployment Controller Type - CODE_DEPLOY or ECS
  }
}
