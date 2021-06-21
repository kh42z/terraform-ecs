output "cluster_id" {
  description = "ecs cluster id"
  value       = aws_ecs_cluster.default.id
}
