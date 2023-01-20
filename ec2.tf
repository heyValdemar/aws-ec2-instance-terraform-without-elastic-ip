# EC2 Instance creation
resource "aws_instance" "ec2_1" {
  ami                    = data.aws_ami.ubuntu_22_04.id
  subnet_id              = aws_subnet.subnet_1.id
  instance_type          = var.aws_instance_type
  key_name               = var.aws_key_pair_name
  vpc_security_group_ids = [aws_security_group.security_group_1.id]

  # Root volume size configuration
  root_block_device {
    volume_size           = var.aws_root_volume_size_gb
    volume_type           = var.aws_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # EBS volume size configuration
  ebs_block_device {
    device_name           = var.aws_ebs_volume_name
    volume_size           = var.aws_ebs_volume_size_gb
    volume_type           = var.aws_ebs_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  # Instance connection establishment
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("./${var.aws_key_pair_name}.pem")
    timeout     = "3m"
  }

  # Instance configuration
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt remove -y needrestart",
      "sudo apt upgrade -y",
      "sudo apt autoremove -y",
      "sudo reboot"
    ]
  }

  depends_on = [
    tls_private_key.private_key_1,
    aws_key_pair.key_pair_1
  ]

  tags = {
    Name      = "ec2-instance-1"
    Terraform = "true"
  }
}

# Private key encryption configuration
resource "tls_private_key" "private_key_1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Private key creation
resource "aws_key_pair" "key_pair_1" {
  key_name   = var.aws_key_pair_name
  public_key = tls_private_key.private_key_1.public_key_openssh

  # Private key export
  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.private_key_1.private_key_pem}' > ./'${var.aws_key_pair_name}'.pem
      chmod 600 ./'${var.aws_key_pair_name}'.pem
    EOT
  }

  depends_on = [
    tls_private_key.private_key_1
  ]
}