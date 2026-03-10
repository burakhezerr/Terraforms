resource "aws_security_group" "ec2_remote_exec_sg" {
    name = "ec2-remote-exec-sg"
    description = "Security group for EC2 remote exec"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "SSH from anywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "All traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        var.default_tags,
        { 
            Name = "${var.project_name}-ec2-remote-exec-sg"
        }
    )
}

