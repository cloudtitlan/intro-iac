#--------------------------------------------------------------
# ECS Cluster
#--------------------------------------------------------------
resource "aws_ecs_cluster" "cluster" {
  name = "intro-iac"
}
