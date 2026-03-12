resource "aws_instance" "ec2_instance" {
  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id

  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = aws_key_pair.ec2_key.key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.instance_user
    private_key = file("${path.module}/../../ec2-keypair.pem")
  }

  provisioner "local-exec" {
    when    = create
    command = <<-EOT
      echo '${tls_private_key.rsa.private_key_pem}' > '${aws_key_pair.ec2_key.key_name}.pem'
      chmod 400 ${aws_key_pair.ec2_key.key_name}.pem
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f 'ec2-keypair.pem'"
  }

  provisioner "remote-exec" {
    when = create
    inline = [
      "whoami",
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker ec2-user",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose"
    ]
  }

  tags = merge(var.default_tags, {
    Name = var.instance_name
  })

  depends_on = [
    aws_key_pair.ec2_key,
    local_file.private_key,
    tls_private_key.rsa
  ]
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-keypair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = "ec2-keypair.pem"
  file_permission = "0400"
}
