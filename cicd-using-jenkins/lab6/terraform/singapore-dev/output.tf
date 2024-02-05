output "instance_ip_addr_public" {
  value = module.compute.instance_ip_addr_public
}

output "instance_ip_addr_private" {
  value = module.compute.instance_ip_addr_private
}

output "alb_dns" {
  value = module.load_balance.alb_dns
}
