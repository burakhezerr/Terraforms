locals {
    account_id         = data.aws_caller_identity.current.account_id
    availability_zones = data.aws_availability_zones.available.names
}