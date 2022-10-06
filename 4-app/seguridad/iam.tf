#--------------------------------------------------------------
# IAM Role and Instance Profile for EC2 instances
#--------------------------------------------------------------
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "intro-iac-ecsInstanceRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

data "aws_iam_policy" "AmazonEC2ContainerServiceforEC2Role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerServiceforEC2Role.arn
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "intro-iac-ecsInstanceRole"
  role = aws_iam_role.ecs_instance_role.name
}

#--------------------------------------------------------------
# ECS Task Execution Role
#--------------------------------------------------------------
data "aws_iam_policy_document" "instance-assume-role-policy-ter" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "intro-iac-ecsTaskExecutionRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy-ter.json
}

data "aws_iam_policy" "AmazonECSTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "taskexecutionrole-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = data.aws_iam_policy.AmazonECSTaskExecutionRolePolicy.arn
}

#--------------------------------------------------------------
# Service Role for ECS
#--------------------------------------------------------------
data "aws_iam_role" "AWSServiceRoleForECS" {
  name = "AWSServiceRoleForECS"
}

#--------------------------------------------------------------
# ECS Application Role
#--------------------------------------------------------------
data "aws_iam_policy_document" "ecs_app_trust_relationship" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_app_role" {
  name               = "intro-iac-ecsAppRole"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_app_trust_relationship.json
}

data "aws_iam_policy" "AmazonSQSFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_app_role_sqs" {
  role       = aws_iam_role.ecs_app_role.name
  policy_arn = data.aws_iam_policy.AmazonSQSFullAccess.arn
}
