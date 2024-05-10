output "cluster_name" {
  value = aws_ecs_cluster.this[0].name
}

output "ecs_service_name" {
  value = aws_ecs_service.this[0].name
}