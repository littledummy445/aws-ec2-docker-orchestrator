# aws-ec2-docker-orchestrator

This repository provisions an Amazon EC2 host with Terraform and boots a Dockerized Node.js application using cloud-init user data.

## Architecture overview

- **Terraform** provisions AWS infrastructure:
  - Latest **Amazon Linux 2023** AMI lookup
  - Security group allowing inbound **SSH (22)** and **HTTP (80)**
  - EC2 instance that executes `scripts/user-data.sh` at launch
- **User data script** configures the instance:
  - Updates system packages
  - Installs Docker and Docker Compose plugin
  - Creates `/opt/app` and writes app/container files
  - Starts the application stack with `docker compose up -d`
- **Application** is a simple Express server listening on port 80 and returning:
  - `Hello from Containers running on Amazon EC2!`

## Repository structure

```text
.
├── .github/workflows/validate.yml
├── app/
│   ├── Dockerfile
│   ├── index.js
│   └── package.json
├── docker-compose.yml
├── scripts/
│   └── user-data.sh
└── terraform/
    ├── main.tf
    ├── outputs.tf
    └── variables.tf
```

## Prerequisites

1. AWS account and IAM credentials configured locally (for Terraform).
2. Terraform CLI (1.5+ recommended).
3. SSH key pair available in your AWS account (add `key_name` in `terraform/main.tf` if needed).

## Deployment instructions

1. **Clone the repository** and move into it:
   ```bash
   git clone <your-fork-or-repo-url>
   cd aws-ec2-docker-orchestrator
   ```

2. **Initialize Terraform**:
   ```bash
   cd terraform
   terraform init
   ```

3. **Review the execution plan**:
   ```bash
   terraform plan
   ```

4. **Apply infrastructure changes**:
   ```bash
   terraform apply
   ```

5. **Get outputs**:
   - `instance_public_ip`
   - `application_url`

6. **Open the application URL** in your browser once the EC2 bootstrap completes.

## Validation workflow

GitHub Actions workflow at `.github/workflows/validate.yml` runs on pushes and pull requests to `main` and performs:

1. `terraform fmt -check -recursive`
2. `terraform init`
3. `terraform validate`

## Cleanup

Destroy created resources when done:

```bash
cd terraform
terraform destroy
```
