output "target_group_blue_arn" {
  value = aws_lb_target_group.nodejs_target_group_blue.arn
}
output "target_group_green_arn" {
  value = aws_lb_target_group.nodejs_target_group_green.arn
}
output "listener_blue_arn" {
  value = aws_lb_listener.listener_blue.arn
}
output "listener_green_arn" {
  value = aws_lb_listener.listener_green.arn
}
output "alb_arn" {
  value = aws_lb.load_balancer.arn
}
output "alb_dns" {
  value = aws_lb.load_balancer.dns_name
}