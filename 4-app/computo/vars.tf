variable "sg_app_instances" {}
variable "sg_loadbalancer" {}
variable "ecs_instance_profile" {}
variable "certificate_arn" {}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
