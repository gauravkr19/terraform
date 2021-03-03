provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3YI6BFYDCELEFCJS"
  secret_key = "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"
}

module "ec2_instance" {
  source     = "./modules/ec2"
  subnet_ids = module.vpc.public_subnets[*]
  inst_count = 2
  vpcid = module.vpc.vpc-id
  }

module "vpc" {
  source = "./modules/vpc"
  subnet_count = 2
  // vpc-cidr = "10.0.0.0/16"
  // public_subnets = "10.0.1.0/24"
  // public_subnets = aws_subnet.public.id
  // vpc_tag = {
  // Name = "prod-vpc"
  // }
}


output "access-url" {
  value = module.ec2_instance.access-url[0]
}



/*
resource "aws_network_interface" "ip" {
  subnet_id   = module.vpc.public_subnets
}

output "pvt-key" {
  value = module.ec2_instance.private_key_pem
}

resource "aws_eip" "pub_ip" {
  vpc                       = true
  network_interface         = aws_network_interface.ip.id
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2_instance.instance_ids[0]
  allocation_id = aws_eip.pub_ip.id
}
****************
resource "aws_eip" "pub_ip" {
  vpc = true
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2_instance.instance_ids[0]
  allocation_id = aws_eip.pub_ip.id
}
resource "aws_instance" "web" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}
*/