output "windows_instance_id" {
    description = "ID of the Windows EC2 instance"
    value       = aws_instance.windows_instance.id
}
