resource "aws_instance" "windows_instance" {
    ami                                  = var.windowsAMI
    instance_type                        = var.windows_instance_type
    
    associate_public_ip_address          = false
    iam_instance_profile                 = var.iam_ssm_instance_profile
    
    key_name                             = aws_key_pair.generated.key_name
    subnet_id                            = var.private_subnets[0].id
    vpc_security_group_ids               = [var.windows_sg_id]

    tags = {
        Name = "${var.project_name}-windows-instance"
    }

    # SSM Agent Setup to enable Session Manager
    user_data = <<-EOF
        <powershell>
        # SSM Agent Setup
        Invoke-WebRequest https://s3.eu-central-1.amazonaws.com/amazon-ssm-eu-central-1/latest/windows_amd64/AmazonSSMAgentSetup.exe -OutFile C:\temp\AmazonSSMAgentSetup.exe
        Start-Process -FilePath C:\temp\AmazonSSMAgentSetup.exe -ArgumentList "/quiet" -Wait
        Start-Service AmazonSSMAgent
        Set-Service -Name AmazonSSMAgent -StartupType Automatic
        </powershell>
    EOF
}

resource "tls_private_key" "generated_private_key" {
    algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
    content  = tls_private_key.generated_private_key.private_key_pem
    filename = "${var.project_name}-keypair.pem"
}

resource "aws_key_pair" "generated" {
    key_name   = "${var.project_name}-keypair"
    public_key = tls_private_key.generated_private_key.public_key_openssh
}