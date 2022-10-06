resource "aws_s3_bucket" "bucket" {
  force_destroy = true

  tags = {
    Builder = "Terraform"
  }
}