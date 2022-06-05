module "simple_server_vpc" {
  source = "../terraform-aws-vpc"
  name = "simple_server_vpc"
  cidr_block = var.cidr_block
}



variable "cidr_block" {
  description = "cidr block"
  type = string
  default = "10.0.0.0/16"
}