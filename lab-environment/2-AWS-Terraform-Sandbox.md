# AWS Sandbox — Terraform for the CI/CD IAM Chain

Reproduces the `mdx-cicd-deploy` role chain (F-22, Module19) in a **throwaway AWS sandbox account you control** — never a shared or production account. This mirrors the approach of public training projects like BishopFox's IAM Vulnerable.

## Prerequisites

- A dedicated AWS sandbox account (consider AWS Organizations + a disposable member account, or an account with hard billing alerts/guardrails set)
- Terraform ≥1.5, AWS CLI configured with sandbox credentials only

## main.tf

The full, CI-validated file lives at [`terraform/main.tf`](terraform/main.tf) — excerpt below.

```hcl
terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
  # Use a dedicated sandbox profile — never your default/production credentials
  profile = "mdx-lab-sandbox"
}

# Intentionally over-permissioned CI/CD role — reproduces F-22
resource "aws_iam_role" "cicd_deploy" {
  name = "mdx-cicd-deploy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "cicd_overpermissive" {
  name = "overpermissive-deploy-policy"
  role = aws_iam_role.cicd_deploy.id
  # VULNERABLE BY DESIGN: iam:PassRole with no resource/condition restriction — this
  # is exactly the F-22 finding. Never apply this pattern outside an isolated lab.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["iam:PassRole"], Resource = "*" },
      { Effect = "Allow", Action = ["lambda:CreateFunction", "lambda:UpdateFunctionCode"], Resource = "*" },
      { Effect = "Allow", Action = ["ec2:RunInstances"], Resource = "*" }
    ]
  })
}

resource "aws_iam_role" "ec2_admin_equivalent" {
  name = "mdx-ec2-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_admin" {
  role       = aws_iam_role.ec2_admin_equivalent.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"  # deliberately broad, for the lab scenario only
}

# Public-listable S3 bucket — reproduces F-23
resource "aws_s3_bucket" "assets" {
  bucket = "mdx-lab-s3-assets-${random_id.suffix.hex}"
}
resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "random_id" "suffix" { byte_length = 4 }
```

## Validating the Chain

```bash
terraform init && terraform plan && terraform apply

# Reproduce the enumeration/simulation from Module19
aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::<acct>:role/mdx-cicd-deploy \
  --action-names lambda:CreateFunction iam:PassRole --profile mdx-lab-sandbox
```

## Teardown (do this every time)

```bash
terraform destroy
```

CI (`.github/workflows/terraform-validate.yml`) runs `terraform fmt -check` and `terraform validate` on every change to `terraform/` — it never runs `apply`; deployment to a real sandbox account stays a manual, deliberate step.
