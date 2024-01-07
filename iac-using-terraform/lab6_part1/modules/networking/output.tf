output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway.id
}