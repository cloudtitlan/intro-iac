resource "aws_sqs_queue" "queue" {
  tags = {
    Builder = "Terraform"
  }
}