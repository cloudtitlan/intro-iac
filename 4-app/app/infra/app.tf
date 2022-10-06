resource "aws_cloudwatch_log_group" "logs" {
  name = "/ecs/intro-iac/app"
}

data "template_file" "container_definition" {
  template = file("${path.module}/archivos/container-definition.json")

  vars = {
    container_name     = "app"
    image_repository   = var.repository_url
    image_tag          = var.image_tag
    memory_reservation = "128"
    port               = "8080"
    log_group          = aws_cloudwatch_log_group.logs.name
    region             = "us-west-2"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "intro-iac"
  container_definitions    = data.template_file.container_definition.rendered
  execution_role_arn       = var.ecs_task_execution_role
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "service" {
  name            = "intro_iac"
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  iam_role        = var.aws_ecs_service_role

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "app"
    container_port   = 8080
  }
}

resource "aws_lb_target_group" "target_group" {
  name                 = "intro-iac"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 60

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 25
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = var.listener_arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    host_header {
      values = ["${var.subdomain}.${var.domain}"]
    }
  }
}

resource "aws_route53_record" "subdomain" {
  zone_id = var.zone_id
  name    = var.subdomain
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}