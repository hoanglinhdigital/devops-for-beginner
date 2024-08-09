#Application Load Balancer
resource "aws_lb" "load_balancer" {
  name               = "udemy-devops-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.load_balance_security_group_ids
  subnets            = var.load_balance_subnet_ids
  enable_deletion_protection = false
  enable_http2               = true
  idle_timeout               = 60
  enable_cross_zone_load_balancing = true
  tags = {
    Name = "udemy-devops-alb"
  }
}

#Load Balancer Listener 80
resource "aws_lb_listener" "listener80" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_target_group_blue.arn
  }
}
#Load Balancer Listener 81
resource "aws_lb_listener" "listener81" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "81"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nodejs_target_group_green.arn
  }
}
#Target Group Blue
resource "aws_lb_target_group" "nodejs_target_group_blue" {
  name        = "target-group-blue"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}
#Target Group Green
resource "aws_lb_target_group" "nodejs_target_group_green" {
  name        = "target-group-green"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "3000"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}