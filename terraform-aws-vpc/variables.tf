variable "name" {
  description = "name of the VPC"
  type = string
}

variable "cidr_block" {
  description = "CIDR block"
  type = string
}

variable "additional_cidr_blocks" {
  description = "additional CIDR blocks to association with this VPC"
  default = []
  type = list(string)
}

variable "enable_private_dns" {
  description = "enable private DNS resolution"
  default = true
  type = bool
}

