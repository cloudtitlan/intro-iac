output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "listener_arn" {
  value = aws_lb_listener.https.arn
}

output "lb_zone_id" {
  value = aws_lb.alb.zone_id
}

output "lb_dns_name" {
  value = aws_lb.alb.dns_name
}