output "iam_ssm_instance_profile" {
    description = "Name of the IAM instance profile for SSM"
    value       = aws_iam_instance_profile.ssm_instance_profile.name
}
