resource "aws_ecr_repository" "intro_iac" {
  name                 = "intro-iac"
  image_tag_mutability = "MUTABLE"
}