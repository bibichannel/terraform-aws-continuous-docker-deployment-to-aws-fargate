output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_rtb_01_id" {
  value = aws_route_table.private_rtb_01.id
}

output "private_rtb_02_id" {
  value = aws_route_table.private_rtb_02.id
}

output "sg_alb_id" {
  value = aws_security_group.alb.id
}

output "sg_ecs_tasks_id" {
  value = aws_security_group.ecs_tasks.id
}

output "sg_ecr_endpoint_id" {
  value = aws_security_group.ecr_endpoint.id
}
