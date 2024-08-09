output "target_group_arn" {
  value = aws_lb_target_group.nodejs_target_group.arn
}
output "alb_arn" {
  value = aws_lb.load_balancer.arn
}
output "alb_dns" {
  value = aws_lb.load_balancer.dns_name
}