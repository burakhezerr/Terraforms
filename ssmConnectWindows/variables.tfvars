azs = ["a", "b", "c"]

private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
project_name = "ssmWindowsPrivate"
public_subnet_cidrs = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]

region = eu-central-1
subnet_count = 3

windowsAMI = "ami-0af0e9617aaeff697"
windows_instance_type = "t3.medium"
vpc_cidr_block = "10.0.0.0/16"
vpc_endpoint_type = "Interface"