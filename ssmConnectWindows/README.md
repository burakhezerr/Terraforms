# AWS Windows Instance Setup and SSM Connection Guide

This guide provides instructions on how to set up a Windows instance on AWS using Terraform and connect to it via AWS Systems Manager (SSM). It also includes steps for installing the SSM Session Manager Plugin on your local machine.

## Prerequisites

- **Terraform**: [Terraform Download](https://www.terraform.io/downloads.html)
- **AWS CLI**: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- **SSM Session Manager Plugin**: [Session Manager Plugin Installation Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- AWS account with necessary permissions
- **Important!** Edit the `variables.tf` file in the root path according to your specific configuration.
- **You must be sure** awscli is installed in your local machine, you can check with this:

```bash
aws --version
```

- **Also,** your aws credentials must be configured in your local machine:

```bash
aws configure
```
You can use this command to configure your AWS account with local machine

## Step 1: Set Up the Project Directory

Create a directory for your project and navigate to it:

```bash
mkdir aws-windows-ssm
cd aws-windows-ssm
```

## Step 2: Clone this repository into your local machine

```bash
git clone https://github.com/burakhezerr/Terraforms.git
```
But this command clones all folders in this repository, you can remove all other things 

## Step 3: Just look at the terraform code:
Especially `variables.tfvars`. It includes the project details:
- Which region is used?
- How many azs available?
- The CIDR ranges
- Windows EC2 machine instance AMI and type.

**Be careful also** `./modules/ec2/main.tf`. Because the fifth line, **keypair has been commanded**. So add the new keypair in your AWS account on the AWS Management Console, **put a name, and change this line according to the name of keypair.**

Just change these variables for whatever your plan to use in AWS

## Step 4: Initialize Terraform

Initialize Terraform in your project directory to download the required providers and modules:

```bash
terraform init
```

## Step 5: Plan Terraform Configuration
Just run this command to see what terraform creates:

```bash
terraform plan -var-file="variables.tfvars"
```

Use -var-file parameter to use varibles that is stored in `variables.tfvars`.

## Step 6: Apply Terraform Configuration

Apply the Terraform configuration to create the AWS resources:

```bash
terraform apply -var-file="variables.tfvars"
```

Review the plan and type `yes` to confirm and create the resources.

## Step 7: Install SSM Session Manager Plugin

### For Windows:

1. Download the installer from [Session Manager Plugin for Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-windows).
2. Run the `.msi` file and follow the installation instructions.

### For macOS:

Use Homebrew to install the plugin:

```bash
brew install --cask session-manager-plugin
```

### For Linux:

Download and install the package suitable for your distribution. For example, on Ubuntu:

```bash
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
```

Verify the installation:

```bash
session-manager-plugin --version
```

## Step 8: Connect to Your Windows Instance via SSM

Use AWS CLI to start a port forwarding session to your Windows instance for RDP access:

```bash
aws ssm start-session     --target <instance-id>     --document-name AWS-StartPortForwardingSessionToRemoteHost     --parameters '{"host":["127.0.0.1"],"portNumber":["3389"],"localPortNumber":["3390"]}'
```

- Replace `<instance-id>` with your actual instance ID.
- This command forwards the RDP port (3389) on your instance to port 3390 on your local machine.

## Step 9: Access the Instance via RDP

Open your RDP client and connect to `localhost:3390` using the Administrator username and password you set.

## Additional Configuration

Ensure the following:

- **IAM Roles and Policies:** The EC2 instance must have an IAM role attached with the `AmazonSSMManagedInstanceCore` policy.
- **VPC Endpoints:** Ensure SSM, SSM Messages, and EC2 Messages endpoints are set up in your VPC for secure communication.
- **Security Groups:** Properly configure security groups to restrict access to required ports and IP ranges.

## Troubleshooting

If you encounter issues connecting to your instance:

- Verify that the SSM Agent is running on your instance.
- Check that the necessary IAM roles and policies are attached.
- Ensure that your local IP is allowed in the security group settings if directly accessing ports.

## Cleanup

To remove all resources created by Terraform:

```bash
terraform destroy -var-file="variables.tfvars"
```

Confirm the plan by typing `yes`.

---

This completes the setup and connection guide for AWS Windows instances using Terraform and AWS Systems Manager. If you have any further issues or questions, please refer to the AWS documentation or seek additional support.
