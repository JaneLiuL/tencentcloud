variable "vpc_name" {
    default = "dev-study"
    type = string
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_tag" {
    default = {
    "test" = "test"
  }
}

variable "availability_zone" {
  default = "ap-guangzhou-4"
}

variable "public_subnet" {
    default = "10.0.0.0/16"
}

variable "private_subnet" {
    default = "10.0.1.0/16"
}

variable "bastion_ssh" {
    default = "192.176.1.81/32"
}