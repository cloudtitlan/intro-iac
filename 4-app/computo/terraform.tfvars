ecs_instance_profile = "arn:aws:iam::050416479387:instance-profile/intro-iac-ecsInstanceRole"
sg_app_instances     = "sg-000258dbcdb9318ad"
sg_loadbalancer      = "sg-078ec844a08cae30d"
certificate_arn      = "arn:aws:acm:us-west-2:050416479387:certificate/4e4dc013-368c-4b9c-a7e1-e5072ea0bc11"
private_subnets = [
  "subnet-000f30467a8227f6c",
  "subnet-0af543a1b16c2cab6",
  "subnet-0ff8d3d6f017f3e14",
]
public_subnets = [
  "subnet-04207f9eeebf9af36",
  "subnet-006b4fc8261524c58",
  "subnet-07d28b91f7414d341",
]