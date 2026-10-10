terraform {
  required_version = ">= 1.5"
  required_providers {
    aws    = { source = "hashicorp/aws", version = "~> 5.0" }
    random = { source = "hashicorp/random", version = "~> 3.0" }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

variable "aws_region" {
  description = "Sandbox region — never point this at a production account/region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "A dedicated AWS CLI profile for a throwaway sandbox account only"
  type        = string
  default     = "mdx-lab-sandbox"
}

# --- Intentionally over-permissioned CI/CD role — reproduces F-22 ---
# WARNING: This configuration is deliberately vulnerable training material.
# Deploy ONLY in an isolated, disposable AWS sandbox account. Never apply
# against a shared, production, or client-owned account.
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
  tags = { Project = "operation-meridian-lab", Purpose = "training-vulnerable-by-design" }
}

resource "aws_iam_role_policy" "cicd_overpermissive" {
  name = "overpermissive-deploy-policy"
  role = aws_iam_role.cicd_deploy.id
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
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = { Project = "operation-meridian-lab", Purpose = "training-vulnerable-by-design" }
}

resource "aws_iam_role_policy_attachment" "ec2_admin" {
  role       = aws_iam_role.ec2_admin_equivalent.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# --- Public-listable S3 bucket — reproduces F-23 ---
resource "random_id" "suffix" { byte_length = 4 }

resource "aws_s3_bucket" "assets" {
  bucket = "mdx-lab-s3-assets-${random_id.suffix.hex}"
  tags   = { Project = "operation-meridian-lab", Purpose = "training-vulnerable-by-design" }
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

output "cicd_role_arn" {
  value = aws_iam_role.cicd_deploy.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assets.bucket
}
