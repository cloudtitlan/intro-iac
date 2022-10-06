ecs_task_execution_role = "arn:aws:iam::050416479387:role/intro-iac-ecsTaskExecutionRole"
cluster_name            = "intro-iac"
repository_url          = "050416479387.dkr.ecr.us-west-2.amazonaws.com/intro-iac"
aws_ecs_service_role    = "arn:aws:iam::050416479387:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
vpc_id                  = "vpc-0940721ea40b2971b"
listener_arn            = "arn:aws:elasticloadbalancing:us-west-2:050416479387:listener/app/intro-iac/51075940d72da615/5fb5125bccd32d2f"
zone_id                 = "Z098898011ADS39JIA10M"
lb_dns_name             = "intro-iac-309708681.us-west-2.elb.amazonaws.com"
lb_zone_id              = "Z1H1FL5HABSF5"

image_tag     = "test"
desired_count = 2
subdomain     = "intro"
domain        = "eks.cloudtitlan.com"