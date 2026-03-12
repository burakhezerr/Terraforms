output "skyloop_vpc_id" {
  description = "VPC ID of the Skyloop account"
  value       = aws_vpc.skyloop_vpc.id
}

output "levelafrica_vpc_id" {
  description = "VPC ID of the Level Africa account"
  value       = aws_vpc.levelafrica.id
}
