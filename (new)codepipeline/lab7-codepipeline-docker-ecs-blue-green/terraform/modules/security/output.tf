output "public_security_group_id" {
  value = aws_security_group.public_security_group.id
}
output "private_security_group_id" {
  value = aws_security_group.private_security_group.id
}