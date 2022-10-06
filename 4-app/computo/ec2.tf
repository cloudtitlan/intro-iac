#--------------------------------------------------------------
# Launch Configuration
#--------------------------------------------------------------
data "aws_ami" "ecs_optimized_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
  owners = ["amazon"]
}

data "template_file" "user_data" {
  template = file("${path.module}/archivos/user-data.sh")

  vars = {
    cluster_name = aws_ecs_cluster.cluster.name
  }
}

resource "aws_launch_configuration" "ecs_launch_configuration" {
  name_prefix          = "intro-iac"
  image_id             = data.aws_ami.ecs_optimized_ami.image_id
  instance_type        = "t2.small"
  security_groups      = [var.sg_app_instances]
  user_data            = data.template_file.user_data.rendered
  iam_instance_profile = var.ecs_instance_profile

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Auto Scaling Group
#--------------------------------------------------------------
resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix          = "intro-iac"
  launch_configuration = aws_launch_configuration.ecs_launch_configuration.id
  vpc_zone_identifier  = var.private_subnets

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  tag {
    key                 = "Name"
    value               = "ecs-intro-iac-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}