# EC2 instance'a IAM role'u atama
resource "aws_instance" "windows_instance" {
    ami                                  = var.windowsAMI
    associate_public_ip_address          = false
    instance_type                        = var.windows_instance_type
    # key_name                           = var.bastion_host_keypair
    subnet_id                            = var.private_subnets[0].id
    vpc_security_group_ids               = [var.windows_sg]
    iam_instance_profile                 = var.iam_ssm_instance_profile

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