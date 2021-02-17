  variable "inst_count" {
    type        = number
    default     = 1
    description = "ec2 count"
  } 
  
  variable "subnet_ids" {
    type    = string
    default = "10.0.1.0/24"
  }

  variable "vpcid" {
    type    = string
  }
