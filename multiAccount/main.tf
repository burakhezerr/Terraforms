resource "aws_vpc" "skyloop_vpc" {
  provider             = aws.skyloop
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name        = "${local.project_name_1}-vpc"
    Environment = "production"
  })
}

resource "aws_vpc" "levelafrica" {
  provider             = aws.levelafrica
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name        = "${local.project_name_2}-vpc"
    Environment = "production"
  })
}
