variable "vpc_tag" {
  type        = map
    default     = {
    Name = "main"
    env  = "stage"
  }
}

variable "private_subnets" {
  type = string
  default = "10.0.0.16/28"
}

/*
variable "public_subnets" {
  type = string
//  default = "10.0.0.0/28"
}
*/

variable "vpc-cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_count" {
  type = number
}
