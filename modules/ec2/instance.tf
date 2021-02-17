data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id = var.subnet_ids
  count = var.inst_count
  key_name   = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
  tags = {
    Name = "web-app"
  }

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl enable httpd
  sudo systemctl start httpd
  echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
  EOF
  }

//variable "key_name" {}
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = "ec2-access-key"
  public_key = tls_private_key.example.public_key_openssh
}
resource "local_file" "cloud_pem" { 
  filename = "/home/cloud_user/pract1_terracode/ec2-access-key.pem"
  content = tls_private_key.example.private_key_pem
}

output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = aws_instance.app.*.id
}
output "access-url" {
  value = aws_instance.app.*.public_dns
}

resource "aws_security_group" "ssh-allowed" {
  vpc_id = var.vpcid  //"vpc-0a4c5905f3ab27ae0"
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }        
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-web-allowed"
    }
}