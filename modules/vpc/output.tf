/*
output "private_subnets" {
  value       = aws_subnet.private.id
}
*/

output "vpc-id" {       //for sg
  value = aws_vpc.main.id
}

output "public_subnets" {     //for subnet in ec2
  value       = aws_subnet.public.id
}
