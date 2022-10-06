output "aws_ecs_service_role" {
  value = data.aws_iam_role.AWSServiceRoleForECS.arn
}

output "ecs_instance_profile" {
  value = aws_iam_instance_profile.ecs_instance_profile.arn
}

output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_app_role" {
  value = aws_iam_role.ecs_app_role.arn
}

output "sg_app_instances" {
  value = aws_security_group.app_instances.id
}

output "sg_loadbalancer" {
  value = aws_security_group.loadbalancer.id
}
