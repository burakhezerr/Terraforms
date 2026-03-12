# Terraforms

Terraform infrastructure-as-code projects for provisioning AWS resources.

## Projects

### [`ssmConnectWindows/`](./ssmConnectWindows)
Provisions a Windows EC2 instance accessible via AWS Systems Manager Session Manager — no public IP or bastion host required. Includes VPC with public/private subnets, NAT gateways, SSM VPC endpoints, and IAM roles.

### [`multiAccount/`](./multiAccount)
Multi-account AWS setup that provisions VPCs in two separate AWS accounts using named profiles. Demonstrates cross-account provider aliasing in Terraform.

### [`ecs-exec/`](./ecs-exec)
ECS Fargate cluster with ECS Exec enabled for interactive container access. Includes VPC, IAM roles, CloudWatch logging, auto-scaling, and a modular ECS service definition.

### [`ec2-remoteExec/`](./ec2-remoteExec)
EC2 instance provisioned with Terraform's `remote-exec` provisioner. Automatically installs Docker and Docker Compose on an Amazon Linux 2 instance via SSH after creation.

## Usage

Each project is standalone. Navigate into a directory and run:

```bash
terraform init
terraform plan
terraform apply
```

## Requirements

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials/profiles
- For `ssmConnectWindows`: AWS Session Manager plugin installed locally

## .gitignore

State files, lock files, and secrets are excluded:
```
*.tfstate
*.tfstate.backup
.terraform/
.terraform.lock.hcl
*.zip
.DS_Store
```
