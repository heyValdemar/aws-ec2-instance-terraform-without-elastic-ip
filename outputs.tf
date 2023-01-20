output "aws_instance_private_ip" {
  description = "EC2 Private IP address"
  value       = aws_instance.ec2_1.private_ip
}