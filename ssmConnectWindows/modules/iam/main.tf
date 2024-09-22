# IAM Role for SSM access to EC2 instances (Windows)
resource "aws_iam_role" "ssm_role" {
    name = "${var.project_name}-ssm-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

# IAM Policy for SSM access to EC2 instances (Windows)
resource "aws_iam_policy_attachment" "ssm_policy_attach" {
    name       = "${var.project_name}-ssm-policy-attach"
    roles      = [aws_iam_role.ssm_role .name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile for SSM access to EC2 instances (Windows)
resource "aws_iam_instance_profile" "ssm_instance_profile" {
    name = "${var.project_name}-ssm-instance-profile"
    role = aws_iam_role.ssm_role.name
}